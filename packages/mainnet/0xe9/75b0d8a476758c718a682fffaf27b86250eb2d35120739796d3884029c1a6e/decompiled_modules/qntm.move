module 0xe975b0d8a476758c718a682fffaf27b86250eb2d35120739796d3884029c1a6e::qntm {
    struct QNTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: QNTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QNTM>(arg0, 9, b"QNTM", b"QUAN7UM_256", b"QUAN7UM_256 AI Agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1847016908685447168/Rmu7Di_J_400x400.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QNTM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QNTM>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QNTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

