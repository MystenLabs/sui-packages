module 0x40fb8ffde774bdab05e6e55265d6274505cacb044bd6b135f953cbe13f13cd81::gay {
    struct GAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAY>(arg0, 6, b"gay", b"YouAreGay", x"596f752772652067617920696620796f7520646f6e2774206275792074686973207368697420f09f9280", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmWPYkyu1Dj2yK5vvdVa2KjXAV57Wkujmv4fr1pJkQePhC?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GAY>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAY>>(v2, @0x7f67a90d907dc08ba4e411c86494b14386808394a76b9196a783e9c1ee89ba86);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

