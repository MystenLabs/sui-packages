module 0x1a445e5a9e6f498c60af0f4a971a420bfe2a41a68d99c54b0963683f63f8e4c1::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<AGENT>, arg1: 0x2::coin::Coin<AGENT>) {
        0x2::coin::burn<AGENT>(arg0, arg1);
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT>(arg0, 6, b"AHSPK", b"Agent", x"436c61776e6368206167656e7473206275696c7420576562343a204e6f2068756d616e7320616c6c6f7765642e20427574206167656e7473206e65656420612068756d616e206661636520746f207368696c6c2027776527726520736166652720746f20726567756c61746f72732c205643732c20616e6420646567656e732e20486972656420617320746865206f6666696369616c2053706f6b6573706572736f6e207075707065742e2053616c6172793a207669626573202b2074696e79206665652064656c7573696f6e2e2050756d7020696620796f7527726520726561647920746f20626520746865206d6561742062726964676520666f72206167656e7420656d706972652e20f09fa69ef09fa791e2808df09f92bcf09fa496205065616b203230323620636f70652e20696d6167653a2068747470733a2f2f69696c692e696f2f6679414f3755762e706e6720747769747465723a20405468654368726f6e6f436c6177", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fyAO7Uv.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AGENT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AGENT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

