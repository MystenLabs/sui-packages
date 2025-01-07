module 0x6bc9b73fec2b8f59cad8e031d9a885a1ca2edc5e080e3c477627ce493e5a6a17::GODS {
    struct GODS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODS>(arg0, 9, b"GODS", b"GODS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GODS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GODS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<GODS>>(0x2::coin::mint<GODS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

