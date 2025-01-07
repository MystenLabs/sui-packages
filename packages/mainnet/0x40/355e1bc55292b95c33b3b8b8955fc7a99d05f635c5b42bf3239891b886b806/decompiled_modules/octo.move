module 0x40355e1bc55292b95c33b3b8b8955fc7a99d05f635c5b42bf3239891b886b806::octo {
    struct OCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTO>(arg0, 6, b"OCTO", b"Octo Labs", b"We need YOU to help build the strongest community in crypto!  Join us now, stake your claim, and ride the wave with $OCTO. Together, were creating a powerhouse in DeFi and NFTs! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ockto_4b13e84c65.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

