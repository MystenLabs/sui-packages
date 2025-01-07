module 0xb97ec2a2c8eee61499f84b744fac5ef64bc29bab7a0060ca1eb07ab6edf15e4::xrp {
    struct XRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRP>(arg0, 6, b"XRP", b"HarryPotterObamaPacman8Inu", b"XRP ETF reason to send it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2481_b7c147af49.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

