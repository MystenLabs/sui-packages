module 0xe46eec34fd9dc1430ed631638424d6750286bfb477d9c4b0ec71697d2e1cc64f::fcpd {
    struct FCPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCPD>(arg0, 9, b"FCPD", b"FlyingCheesePugDog", b"FLYEST DOG ON A CHEETO. FLY LIKE A MOFO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/HsSNPzGYX8hFEkmHnkScXR7BajCNLQcyfZbQyuL6jXkP.png?size=xl&key=7c642b")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FCPD>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCPD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCPD>>(v1);
    }

    // decompiled from Move bytecode v6
}

