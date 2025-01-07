module 0x4668ac512f98bfdb5b45d87ad20d7e97bd16b36a07093c1676ce6c2bdf4f349d::HotFloorCoinscale {
    struct HOTFLOORCOINSCALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOTFLOORCOINSCALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOTFLOORCOINSCALE>(arg0, 0, b"COS", b"HotFloor Coinscale", b"Spare a glint? A glimmer? Don't worry, friend, no one's watching...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_HotFloor_Coinscale.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOTFLOORCOINSCALE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOTFLOORCOINSCALE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

