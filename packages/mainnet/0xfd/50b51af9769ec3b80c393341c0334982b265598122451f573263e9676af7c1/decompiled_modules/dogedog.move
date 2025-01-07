module 0xfd50b51af9769ec3b80c393341c0334982b265598122451f573263e9676af7c1::dogedog {
    struct DOGEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEDOG>(arg0, 6, b"Dogedog", b"Doge2014", b"Doge2014 is a crypto project celebrating the 10th anniversary of Dogecoin, offering tokens at the nostalgic 2014 Dogecoin price and providing opportunities for staking and community rewards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2014_JPG_fb4c846faa.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

