module 0x77d783efca2705e732270b40964111cdeb34002e256b04dd8fc0b3a56df91cc7::cream {
    struct CREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREAM>(arg0, 6, b"CREAM", b"Cream", b"Cream Coin isnt just another tokenits the heartbeat of the Cream Crew. Built for creators, rebels, and those who live on the edge of art, music, and street culture, Cream Coin is your pass to a decentralized world where creativity meets community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cremecoin_7d2b598685.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CREAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

