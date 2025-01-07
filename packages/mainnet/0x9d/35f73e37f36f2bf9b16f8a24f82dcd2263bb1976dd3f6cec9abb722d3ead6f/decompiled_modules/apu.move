module 0x9d35f73e37f36f2bf9b16f8a24f82dcd2263bb1976dd3f6cec9abb722d3ead6f::apu {
    struct APU has drop {
        dummy_field: bool,
    }

    fun init(arg0: APU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APU>(arg0, 6, b"APU", b"Apugurl on SUI", b"Apugurl is the most degen female frog in the crypto space and the ONLY female frog in the 4chan group.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_30_23_50_36_43fc2bbf48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APU>>(v1);
    }

    // decompiled from Move bytecode v6
}

