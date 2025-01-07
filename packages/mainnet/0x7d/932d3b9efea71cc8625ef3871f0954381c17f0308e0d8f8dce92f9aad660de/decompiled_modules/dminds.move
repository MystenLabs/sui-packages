module 0x7d932d3b9efea71cc8625ef3871f0954381c17f0308e0d8f8dce92f9aad660de::dminds {
    struct DMINDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMINDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMINDS>(arg0, 6, b"DMINDS", b"DIAMOND MINDS", b"\"Shine bright, long term players; we Diamond Minds on Sui....\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_12_02_at_8_19_31_PM_9d72046549.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMINDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMINDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

