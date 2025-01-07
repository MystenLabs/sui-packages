module 0xf00283298e8f00c04824c101dffc9973bc91b5561a25be01eecde768f2016570::edog {
    struct EDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDOG>(arg0, 6, b"EDOG", b"EdogSui", b"The firs E-DOG on meme coin sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000652_7a7eab6aba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

