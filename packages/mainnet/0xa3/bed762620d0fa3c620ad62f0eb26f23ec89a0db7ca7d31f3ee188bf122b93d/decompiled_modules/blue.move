module 0xa3bed762620d0fa3c620ad62f0eb26f23ec89a0db7ca7d31f3ee188bf122b93d::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 8, b"BLUE", b"Blue", b"Blue Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x7f65323e468939073ef3b5287c73f13951b0ff5b.png?size=lg&key=1741eb")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUE>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

