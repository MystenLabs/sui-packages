module 0x3d7cc13f2cf4dca2468df79375f56b9089881b38b0d8cb72502f3d19e2b5de99::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG>(arg0, 9, b"GG", b"GGROUP", b"GG nft", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a2aaa4b468bab948de50816a53b3d66eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

