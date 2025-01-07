module 0x3eb148760d8cb7e58ee47c697d34ca441ac4f305fcdf8e236a6ac1862fdc6f38::mugu {
    struct MUGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUGU>(arg0, 6, b"MUGU", b"MUGU SUI", b"$MUGU ON SUI LIVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_09_21_35_28_69cc60ad99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

