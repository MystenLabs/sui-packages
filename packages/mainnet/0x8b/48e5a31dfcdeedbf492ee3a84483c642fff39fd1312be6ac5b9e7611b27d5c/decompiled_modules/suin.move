module 0x8b48e5a31dfcdeedbf492ee3a84483c642fff39fd1312be6ac5b9e7611b27d5c::suin {
    struct SUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIN>(arg0, 6, b"SUIN", b"Suin on Sui", b"Soon..moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6299_afbe779529.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

