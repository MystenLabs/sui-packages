module 0xfb7fc273d0d908a088d0fc9952656a7eb82d28aba7de0e64ddea3537ca080b6a::bibi {
    struct BIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBI>(arg0, 6, b"BIBI", b"Bibibop", b"BIBI is the heart of the Galactic Oddballs, embodying charm, quirkiness, and boundless curiosity. With her vibrant personality and unique presence, this token powers creativity and community growth in the Galactic Oddballs ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_Artwork_f31e1020b9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

