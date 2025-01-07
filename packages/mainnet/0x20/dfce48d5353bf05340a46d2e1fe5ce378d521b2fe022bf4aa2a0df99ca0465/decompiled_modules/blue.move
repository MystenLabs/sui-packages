module 0x20dfce48d5353bf05340a46d2e1fe5ce378d521b2fe022bf4aa2a0df99ca0465::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 6, b"Blue", b"BLUE", b"Blue is more than just a memecoin; we are a movement committed to building a safe and inclusive community. Our team consists of experienced blockchain experts focused on providing a transparent and profitable investment experience. With all supply going directly to liquidity, we ensure that you can invest with confidence, without worrying about scams or uncertainties.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241017_144201_82b3a3a69c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

