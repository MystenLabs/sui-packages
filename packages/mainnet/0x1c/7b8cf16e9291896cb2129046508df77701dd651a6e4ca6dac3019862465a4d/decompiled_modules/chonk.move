module 0x1c7b8cf16e9291896cb2129046508df77701dd651a6e4ca6dac3019862465a4d::chonk {
    struct CHONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHONK>(arg0, 6, b"Chonk", b"SuiChonk", b"Big, bold, and unmissable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_053457035_4d6a025d2d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

