module 0x195e101c69b3317730709ab813b41d5e3131e74e4c57632eef487b8ecb07eddd::chllpo {
    struct CHLLPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHLLPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHLLPO>(arg0, 6, b"CHlLPO", b"CHILL HIPPO DENG", x"4368696c706f207761732061206c6169642d6261636b20686970706f2077686f206c6f7665642072656c6178696e67206279207468652062656163682c20616c7761797320726f636b696e6720686973207369676e617475726520726564206361702e2045766572792073756e7365742c20756e6465722074686520707572706c6520616e642079656c6c6f7720736b792c2068656420696e73706972652065766572796f6e65207769746820686973206d6f74746f3a2053746179206368696c6c2c207269646520746865207761766573206f66206c6966652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9d10d01010_8d48863e20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHLLPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHLLPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

