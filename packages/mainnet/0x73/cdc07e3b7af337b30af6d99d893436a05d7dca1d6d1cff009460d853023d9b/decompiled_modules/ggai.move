module 0x73cdc07e3b7af337b30af6d99d893436a05d7dca1d6d1cff009460d853023d9b::ggai {
    struct GGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GGAI>(arg0, 6, b"GGAI", b"Giga Chad SUAI", x"4769676120436861642069732061206d6f6465726e20696e7465726e6574206d656d652069636f6e20616e6420612068797065722d657861676765726174656420617263686574797065206f6620756c74696d617465206d617363756c696e6974792e204865e2809973206f6674656e2064657069637465642061732061206c61726765722d7468616e2d6c6966652c20696465616c697a65642076657273696f6e206f662061206d616e2077686f20656d626f64696573207065616b20706879736963616c206669746e6573732c2063686973656c65642066616369616c2066656174757265732c20636f6e666964656e63652c20616e6420646f6d696e616e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/giga_5dadeaf149.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GGAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

