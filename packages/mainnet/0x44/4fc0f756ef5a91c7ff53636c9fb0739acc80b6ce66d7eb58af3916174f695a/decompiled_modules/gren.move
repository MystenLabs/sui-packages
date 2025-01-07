module 0x444fc0f756ef5a91c7ff53636c9fb0739acc80b6ce66d7eb58af3916174f695a::gren {
    struct GREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREN>(arg0, 6, b"GREN", b"Gren REX", b"Something big and blue is coming  exclusively", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dino_3d54170d2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

