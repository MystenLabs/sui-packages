module 0x478082125c3a011b2453731cbbf8d2266a3a5a3d917380e42bc5eb5fcbaf6853::suipepe {
    struct SUIPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEPE>(arg0, 6, b"SUIPEPE", b"Sui pepe", b"SUIEPE is the ultimate Tear Drop who can do it all! With his iconic mustache and boundless charm, he embodies the spirit of the SUI chaincreativity, community, and endless fun. SUIEPE is the heartbeat of our vibrant ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241012_112631_593_dfd3ad5d63.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

