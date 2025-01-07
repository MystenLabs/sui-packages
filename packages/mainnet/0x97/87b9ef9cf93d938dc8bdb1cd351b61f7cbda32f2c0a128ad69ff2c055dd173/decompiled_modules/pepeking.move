module 0x9787b9ef9cf93d938dc8bdb1cd351b61f7cbda32f2c0a128ad69ff2c055dd173::pepeking {
    struct PEPEKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEKING>(arg0, 6, b"PepeKing", b"King Pepe", b"The King Pepe isnt just about getting rich (though thats a nice perk!). Its about community, memes, and spreading the good vibes. Were a decentralized kingdom where everyone is welcome, from seasoned crypto veterans to first-time mooners.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_sui_fb8f947130.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

