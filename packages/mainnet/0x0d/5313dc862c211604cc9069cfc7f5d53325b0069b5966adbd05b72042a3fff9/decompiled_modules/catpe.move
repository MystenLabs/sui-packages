module 0xd5313dc862c211604cc9069cfc7f5d53325b0069b5966adbd05b72042a3fff9::catpe {
    struct CATPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATPE>(arg0, 6, b"CATPE", b"Cat Pepe", b"Cats + pepe, what could go wrong?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catpepepfp0_db6c30bf35.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

