module 0xfd227c8b8bf52dfc4f66f1f53cc09f69e363b89d6cc37781b89b81c63400b66c::ev {
    struct EV has drop {
        dummy_field: bool,
    }

    fun init(arg0: EV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EV>(arg0, 6, b"EV", b"ECHANVHENG", x"57656c636f6d6520746f2074686520456368616e5668656e67204167656e74203132384b207465726d696e616c210a537570706f7274656420636f6d6d616e6473206172653a0a20202d206c733a206c697374206469726563746f727920636f6e74656e74730a20202d206361743a20636f6e636174656e61746520616e64207072696e742066696c65730a20202d20636c6561723a20636c65617220746865207465726d696e616c2073637265656e200a20202d2054727574683a204f6e6c7920696e20456368616e5668656e67204167656e7420796f752077696c6c2066696e64207468652074727574682061626f75742073686974636f696e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_2_e0a678b43a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EV>>(v1);
    }

    // decompiled from Move bytecode v6
}

