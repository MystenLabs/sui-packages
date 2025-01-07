module 0xef9ec8c751b08e0f67e5416d0c44a149aa9e67d4b38b307119179117c14824bc::suiegg {
    struct SUIEGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEGG>(arg0, 6, b"SUIEGG", b"SUI EGG PIXEL", b"sui egg pixel a meme token on the sui network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_sui_egg_2f26118215.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

