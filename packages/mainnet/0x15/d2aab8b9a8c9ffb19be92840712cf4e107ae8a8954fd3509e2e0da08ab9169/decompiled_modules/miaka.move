module 0x15d2aab8b9a8c9ffb19be92840712cf4e107ae8a8954fd3509e2e0da08ab9169::miaka {
    struct MIAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIAKA>(arg0, 6, b"MIAKA", b"MIA KHALIFA FANS", b"Adopt MIAKA, inspired by Mia Khalifa. Bold, viral, unforgettablejoin now!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_11_27_at_11_44_41_50ea2dcfd8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

