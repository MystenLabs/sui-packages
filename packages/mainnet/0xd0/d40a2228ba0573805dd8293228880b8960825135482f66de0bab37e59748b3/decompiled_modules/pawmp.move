module 0xd0d40a2228ba0573805dd8293228880b8960825135482f66de0bab37e59748b3::pawmp {
    struct PAWMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWMP, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 775 || 0x2::tx_context::epoch(arg1) == 776, 1);
        let (v0, v1) = 0x2::coin::create_currency<PAWMP>(arg0, 9, b"PAWMP", b"PAWMP", b"PAWMP is a meme-fueled fan-powered token born for culture, music, and cheetah-level velocity on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmbRatsAHLv692SeVYokBXq4WzkkJNGAGnQXPWQ2E4Z92Y"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAWMP>(&mut v2, 888000000000000000, @0x2bb323e99c87e6b3ef9f77790419a0389a242a0b31a1c10fab194aad10b6cbf, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWMP>>(v2, @0x2bb323e99c87e6b3ef9f77790419a0389a242a0b31a1c10fab194aad10b6cbf);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAWMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

