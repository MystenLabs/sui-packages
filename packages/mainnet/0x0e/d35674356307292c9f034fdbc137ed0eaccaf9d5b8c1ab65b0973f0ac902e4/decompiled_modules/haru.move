module 0xed35674356307292c9f034fdbc137ed0eaccaf9d5b8c1ab65b0973f0ac902e4::haru {
    struct HARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARU>(arg0, 6, b"HARU", b"Haru on Sui", b"Haru Universe is coming to #Sui  Follow the journey!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K58_Wqmxy_400x400_7fee661c3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

