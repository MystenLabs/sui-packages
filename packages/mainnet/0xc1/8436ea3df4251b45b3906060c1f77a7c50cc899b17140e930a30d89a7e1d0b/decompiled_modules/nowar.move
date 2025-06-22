module 0xc18436ea3df4251b45b3906060c1f77a7c50cc899b17140e930a30d89a7e1d0b::nowar {
    struct NOWAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOWAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOWAR>(arg0, 9, b"NoWar", b"NO WAR", b"$NoWar is the first peace-driven token on the Sui blockchain, standing against war and violence. More than a token it's a global movement for unity, hope, and decentralized peace. No borders. No violence. Just peace. Join the #NoWar movement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/gigagfun/barrontrump/refs/heads/main/nowar.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NOWAR>>(0x2::coin::mint<NOWAR>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NOWAR>>(v2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOWAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

