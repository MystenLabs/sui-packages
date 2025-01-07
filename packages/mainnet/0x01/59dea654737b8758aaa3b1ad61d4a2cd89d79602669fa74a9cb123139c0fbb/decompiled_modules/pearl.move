module 0x159dea654737b8758aaa3b1ad61d4a2cd89d79602669fa74a9cb123139c0fbb::pearl {
    struct PEARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEARL>(arg0, 6, b"PEARL", b"SUI PEARL", b"Welcome to Sui Pearl community the hidden gem on sui. Big partnership coming up NOW!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_19_14_32_15_8673d2325e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEARL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEARL>>(v1);
    }

    // decompiled from Move bytecode v6
}

