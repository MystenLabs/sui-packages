module 0x7c614f010b2d02c24c28b4dbb21c6445745cc928f37b1c0b3cd972b579a3e234::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 6, b"SUICAT", b"SuimonsCat", b"Suimon's cat, we are committed to transparency, integrity, and excellence in everything we do. We prioritize the needs and interests of our community members and strive to maintain open communication channels at all times. With a focus on continuous improvement and customer satisfaction, we aim to be at the forefront of the blockchain gaming revolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_png_9994facbea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

