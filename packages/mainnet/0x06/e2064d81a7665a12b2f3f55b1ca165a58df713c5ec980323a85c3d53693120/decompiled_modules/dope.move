module 0x6e2064d81a7665a12b2f3f55b1ca165a58df713c5ec980323a85c3d53693120::dope {
    struct DOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPE>(arg0, 6, b"DOPE", b"Sui Dolphin", b"Raiding the meme waves with grace and speed.A $DOPE is flipping for gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiexpejcxm667wiqs7zvlqdnaup4m5rhbbrdifxhiwjwktjw7stloq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

