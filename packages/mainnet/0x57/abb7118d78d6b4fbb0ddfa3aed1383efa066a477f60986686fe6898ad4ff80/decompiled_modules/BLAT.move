module 0x57abb7118d78d6b4fbb0ddfa3aed1383efa066a477f60986686fe6898ad4ff80::BLAT {
    struct BLAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAT>(arg0, 9, b"BLAT", b"BeLaunch Token", b"The launchpad platform is safe and secure for everyone!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://belaunchio.infura-ipfs.io/ipfs/Qme9yNdWnEVgJA4wMK3HeEm6UdvVpJa1gv2y5jLBJK8Jbe"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLAT>>(v1);
        0x2::coin::mint_and_transfer<BLAT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLAT>>(v2);
    }

    // decompiled from Move bytecode v6
}

