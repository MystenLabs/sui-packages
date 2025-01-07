module 0x63af34dd9b86adb6cb997214a7de84ba3f26a684c0387a3237723047de2c8eba::hebo {
    struct HEBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEBO>(arg0, 6, b"HEBO", b"Hebo On Sui", b"mEET $HEBO THE NEWEST SENSATION  LIVING ON THE SUI BLOCKCHAIN! $HEBO IS A CUTE, QUIRKY, LOVING CREATURE HERE TO INCLUDE EVERYONE ON OUR INCREDIBLE JOURNEY! WE HAVE A DEDICATED TEAM WORKING tirelessly TO BRING OUR VISION TO LIFE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048997_83b33547a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

