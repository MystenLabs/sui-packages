module 0x811d7c3a38044436db94d5da1c677b4302c7538ac6ecbb979d48c6a4a2c1617c::CAPO {
    struct CAPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPO>(arg0, 9, b"CAPO", b"CAPO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPO>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CAPO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CAPO>>(0x2::coin::mint<CAPO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

