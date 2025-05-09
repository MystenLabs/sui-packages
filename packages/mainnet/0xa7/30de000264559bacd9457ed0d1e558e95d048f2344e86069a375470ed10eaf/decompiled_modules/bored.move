module 0xa730de000264559bacd9457ed0d1e558e95d048f2344e86069a375470ed10eaf::bored {
    struct BORED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORED>(arg0, 6, b"BORED", b"Bored Boyz Club", b"Bored Boyz was born during one of those long market lulls. Everyone just staring at charts, waiting for the next big thing. So we decided to stop waiting and make it ourselves. $BORED is a coin for the real ones: the bored, the brave, the boyz (and girlz).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihm4zktaxpzvzlhxkpm4uap4mtbscsttpaa3636mpzkpmar6mt2bm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BORED>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

