module 0x228f56870ea5f9335fd8892434aa9395ef2cbe89cc7119cbf0f15c0406b6ada5::niggpat {
    struct NIGGPAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGPAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGPAT>(arg0, 6, b"NiggPat", b"niggapat", x"57656c636f6d6520746f204e69676761205061747269636be2809474686520627261696e6368696c64206f662065766572796f6e652773206661766f726974652073746172666973682c206e6f7720666c697070696e67204b72616262792050617474696573206f6e2074686520626c6f636b636861696e2120506f776572656420627920636f6d6d756e69747920766962657320616e64206c6976696e67206f6e20536f6c616e612c206974e280997320666173746572207468616e205061747269636b206465636964696e67207768617420746f206561742e20f09f9a800a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748782244029.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIGGPAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGPAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

