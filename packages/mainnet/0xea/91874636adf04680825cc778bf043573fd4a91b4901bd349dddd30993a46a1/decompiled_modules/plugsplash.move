module 0xea91874636adf04680825cc778bf043573fd4a91b4901bd349dddd30993a46a1::plugsplash {
    struct PLUGSPLASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUGSPLASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUGSPLASH>(arg0, 6, b"PlugSplash", b"PlugSplash on Sui", b"Thirsty for something new?  PlugSplash Water, the coolest meme token on the Sui blockchain, is here to refresh your portfolio. With a splash of humor and a dash of utility, we're making waves in the cryptoverse. Don't get left out of the fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7326_35dfe62e7a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUGSPLASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUGSPLASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

