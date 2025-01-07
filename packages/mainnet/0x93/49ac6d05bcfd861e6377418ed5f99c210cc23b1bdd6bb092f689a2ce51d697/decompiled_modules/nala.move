module 0x9349ac6d05bcfd861e6377418ed5f99c210cc23b1bdd6bb092f689a2ce51d697::nala {
    struct NALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NALA>(arg0, 6, b"Nala", b"Nala Cat", b"The highest followed cat on Instagram now wants to break all the records on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0537_be52b5f0a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

