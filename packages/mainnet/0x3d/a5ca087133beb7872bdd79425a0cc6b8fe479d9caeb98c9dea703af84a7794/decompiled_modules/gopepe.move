module 0x3da5ca087133beb7872bdd79425a0cc6b8fe479d9caeb98c9dea703af84a7794::gopepe {
    struct GOPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOPEPE>(arg0, 6, b"GOPEPE", b"GOAT PEPE", b"Meet $GOPE, the baby of Goat and Pepe ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_24_15_15_24_80d1156ff8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

