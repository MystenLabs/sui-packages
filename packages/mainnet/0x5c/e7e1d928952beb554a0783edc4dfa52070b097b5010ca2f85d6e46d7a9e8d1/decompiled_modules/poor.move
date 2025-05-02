module 0x5ce7e1d928952beb554a0783edc4dfa52070b097b5010ca2f85d6e46d7a9e8d1::poor {
    struct POOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOR>(arg0, 6, b"POOR", b"POORFOLIO", x"57656c636f6d6520746f20506f6f72666f6c696f2c20746865206f6e6c7920706f7274666f6c696f20747261636b6572207468617420646f65736ee2809974206c696520746f20796f752e204e6f20686f7069756d2c206e6f20677265656e2063616e646c65732c206a75737420707572652c20756e66696c74657265642066696e616e6369616c20646573706169722e0a0a5768657468657220796f7520626f756768742074686520746f702c206170656420696e746f20727567732c206f722062656c696576656420696e207574696c6974792c207765e280997265206865726520746f20636174616c6f6720796f757220646f776e66616c6c2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746211214990.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

