module 0x926db47e3a9606e08f759e5df0ea8ebbf730e183b0611225c17f1d1020009d4b::bbblub {
    struct BBBLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBBLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBBLUB>(arg0, 6, b"BBBLUB", b"Baby Blub", x"526964652074686520776176652077697468204261627920426c75622c207468652061646f7261626c6520737563636573736f7220746f20746865206c6567656e6461727920424c554220746f6b656e206f6e205375692120576974682069747320706c617966756c2073706972697420616e6420636f6d6d756e6974792d64726976656e20636861726d2c204261627920426c7562206973206d616b696e6720612073706c61736820696e20746865206d656d6520636f696e20776f726c642e20446f6ee2809974206d697373207468652074696465e280946a6f696e207468652066756e20746f6461792120f09f8c8af09f909f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736565423046.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBBLUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBBLUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

