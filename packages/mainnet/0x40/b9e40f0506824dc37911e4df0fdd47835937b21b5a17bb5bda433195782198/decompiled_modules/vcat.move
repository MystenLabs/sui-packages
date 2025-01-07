module 0x40b9e40f0506824dc37911e4df0fdd47835937b21b5a17bb5bda433195782198::vcat {
    struct VCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCAT>(arg0, 6, b"VCAT", b"Vibing Cat", b"Vibing Cat isn't just a sensation; it's a purrfect cultural icon, the beacon of positive vibes and feline charm. Join our vibrant community and let the good vibes roll. CMC/CoinGecko/Website is COMING SOON!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_165f0b6337.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

