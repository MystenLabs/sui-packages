module 0x2a8e0b03ddbe44f34b032650b7fb386335304b30435bf2aeb3708abd1c9bcc4b::dodo {
    struct DODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODO>(arg0, 9, b"DODO", b"DODO", b"DODO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"DODO")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DODO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

