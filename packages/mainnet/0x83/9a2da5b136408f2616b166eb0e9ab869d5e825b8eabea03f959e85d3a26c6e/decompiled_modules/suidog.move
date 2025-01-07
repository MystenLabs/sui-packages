module 0x839a2da5b136408f2616b166eb0e9ab869d5e825b8eabea03f959e85d3a26c6e::suidog {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOG>(arg0, 9, b"SuiDog", b"Sui Dog", b"Sui Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.theconversation.com/files/521751/original/file-20230419-18-hg9dc3.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=900.0&fit=crop")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIDOG>>(0x2::coin::mint<SUIDOG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

