module 0x45fbdd27bbae6014d27d6848df472230fba6b9072d9517238b0dbe21a50d55c1::moki {
    struct MOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOKI>(arg0, 6, b"MOKI", b"Moki on Sui", b"Moki is the first ghost meme token on sui and we'll be spooky forever ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035977_64308a4741.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

