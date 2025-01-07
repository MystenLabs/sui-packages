module 0xfc15ac6330e31b14de81d7a3b5355bd54243098a2699ac67f51fa2f5cf3be7fb::wpepe {
    struct WPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WPEPE>(arg0, 9, b"WPEPE", b"Pepe Wave", b"PepeWave is a meme-powered token inspired by the iconic Pepe the Frog. It brings together humor and crypto, creating a fun and engaging way for holders to ride the waves of both internet culture and decentralized finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1794409323684040704/12Zsn_f4.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WPEPE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WPEPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

