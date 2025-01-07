module 0xb56c6015bf79d72ca6e7e3537f8b2f953c5f63a776357ca293c4e49f704a47c0::babyneiro {
    struct BABYNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYNEIRO>(arg0, 6, b"BABYNEIRO", b"Baby Neiro", x"4d697373656420446f67653f204d69737365642042616279446f67653f204d6973736564204e6569726f203530304d3f0a4e6f7720697320796f7572206368616e636520617420426162794e6569726f2c2077652077696c6c20626520657665727977686572652077697468696e20323420686f7572732e0a5374756479202342616279446f6765207468656e2073747564792023426162794e6569726f206974276c6c20616c6c20626520736f206f6276696f75732068696e6473696768742e0a54616b652061206368616e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727176068433_18c306208e1527c0a5ba9f1ea7bc6678_109e8fb126.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYNEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

