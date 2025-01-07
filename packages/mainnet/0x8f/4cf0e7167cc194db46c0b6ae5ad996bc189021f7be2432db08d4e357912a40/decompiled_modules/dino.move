module 0x8f4cf0e7167cc194db46c0b6ae5ad996bc189021f7be2432db08d4e357912a40::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 6, b"DINO", b"T-REX DINOSAUR", b"T-Rex Chrome Dino Game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/QRISTAL_9_58a7bffb12.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

