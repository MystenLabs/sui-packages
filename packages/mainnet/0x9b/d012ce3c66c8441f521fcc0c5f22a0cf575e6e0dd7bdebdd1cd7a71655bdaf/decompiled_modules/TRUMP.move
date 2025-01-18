module 0x9bd012ce3c66c8441f521fcc0c5f22a0cf575e6e0dd7bdebdd1cd7a71655bdaf::TRUMP {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 9, b"TRUMP", b"TRUMP", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUMP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUMP>>(0x2::coin::mint<TRUMP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

