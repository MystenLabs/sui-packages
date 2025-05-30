module 0xa0b033f5ec09804d98d38c3c129c991a8f2f6d4ca6b193d6f0434e496e7dff35::pokewob {
    struct POKEWOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEWOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEWOB>(arg0, 6, b"POKEWOB", b"WOBBUFFET", b"Join the wobble. Reflect the chaos. Counter to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihvzftkcotvcl7c2tnabstl2beuqr767t2x5rjr35uejzf5apom6y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEWOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEWOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

