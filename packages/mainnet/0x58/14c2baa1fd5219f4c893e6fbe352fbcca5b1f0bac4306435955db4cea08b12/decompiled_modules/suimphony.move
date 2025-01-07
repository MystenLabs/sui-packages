module 0x5814c2baa1fd5219f4c893e6fbe352fbcca5b1f0bac4306435955db4cea08b12::suimphony {
    struct SUIMPHONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMPHONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMPHONY>(arg0, 6, b"SUIMPHONY", b"SYMPHONY of the SUI WORLD!", b"SUIMPHONY is the token that transports you to a magical world where dolphins dance in crystal-clear oceans under starry skies and rainbow-filled lands. Dive into this dreamy, harmonious universe on Sui and let the music of the seas guide your way!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimphony_13d63f07c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMPHONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMPHONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

