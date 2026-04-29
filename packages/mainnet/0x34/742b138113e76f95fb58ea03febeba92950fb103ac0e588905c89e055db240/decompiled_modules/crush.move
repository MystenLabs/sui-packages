module 0x34742b138113e76f95fb58ea03febeba92950fb103ac0e588905c89e055db240::crush {
    struct CRUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRUSH>(arg0, 6, b"CRUSH", b"Scam Crusher", b"The official utility token for Scam Crusher Protocol on Sui. Fueling the destruction of scam NFTs. Burn to evolve, hold to earn. Powered by Walrus.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0459_bc807044d0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

