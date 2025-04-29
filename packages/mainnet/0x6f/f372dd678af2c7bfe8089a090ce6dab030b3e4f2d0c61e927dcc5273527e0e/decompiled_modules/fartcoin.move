module 0x6ff372dd678af2c7bfe8089a090ce6dab030b3e4f2d0c61e927dcc5273527e0e::fartcoin {
    struct FARTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTCOIN>(arg0, 6, b"Fartcoin", b"Fartcoin on Sui", x"546f6b656e6973696e672066617274732077697468207468652068656c70206f6620626f74732e0a0a4e6f2054472c206e6f20636162616c2c206661727420667265656c7921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_3_47bb5df53b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

