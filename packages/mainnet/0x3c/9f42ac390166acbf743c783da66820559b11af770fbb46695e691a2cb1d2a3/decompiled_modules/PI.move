module 0x3c9f42ac390166acbf743c783da66820559b11af770fbb46695e691a2cb1d2a3::PI {
    struct PI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PI>(arg0, 9, b"PI", b"PI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<PI>>(0x2::coin::mint<PI>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

