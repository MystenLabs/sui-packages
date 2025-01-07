module 0x860ada4da3f90fdc6a366b03e9b2107e9106a8188563ecb16c5920cc598039d2::suare {
    struct SUARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUARE>(arg0, 6, b"SUARE", b"Suare Sui", b"Suare the evil bunny on SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7776_69ccde6204.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUARE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUARE>>(v1);
    }

    // decompiled from Move bytecode v6
}

