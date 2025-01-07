module 0x79b3aa473b0cdee7e45c8c332d4f9e22a066cf778bc8795a35559abf82fcec40::jellyfish {
    struct JELLYFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLYFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLYFISH>(arg0, 6, b"JELLYFISH", b"Sui JellyFish", b"The Cutest JellyFish in Sui Chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jellyfish_pink_5e43f134d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLYFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JELLYFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

