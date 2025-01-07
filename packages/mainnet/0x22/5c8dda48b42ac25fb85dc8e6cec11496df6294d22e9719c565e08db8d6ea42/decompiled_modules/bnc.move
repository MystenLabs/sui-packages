module 0x225c8dda48b42ac25fb85dc8e6cec11496df6294d22e9719c565e08db8d6ea42::bnc {
    struct BNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNC>(arg0, 6, b"BNC", b"Blue Nub Cat", x"48455920594f552e2e2e2059454820594f552120494d2054484520424c5545204e5542204341542e20490a464f554e442054484953204e455720434841494e2043414c4c4544205355492e204c4f4f4b530a50524554545920434f4f4c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_07_at_6_25_27_PM_f7f7581ea4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

