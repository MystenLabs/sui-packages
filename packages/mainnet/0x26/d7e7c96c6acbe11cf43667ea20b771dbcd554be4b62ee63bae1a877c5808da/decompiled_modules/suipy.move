module 0x26d7e7c96c6acbe11cf43667ea20b771dbcd554be4b62ee63bae1a877c5808da::suipy {
    struct SUIPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPY>(arg0, 6, b"Suipy", b"suipy", b"suipy slippy bop bop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_a_serene_dreamy_infant_with_a_soft_radiant_bl_2_e1d665b97b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

