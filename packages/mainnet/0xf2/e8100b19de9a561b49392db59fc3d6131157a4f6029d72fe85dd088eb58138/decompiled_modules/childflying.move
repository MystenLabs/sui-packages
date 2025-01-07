module 0xf2e8100b19de9a561b49392db59fc3d6131157a4f6029d72fe85dd088eb58138::childflying {
    struct CHILDFLYING has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILDFLYING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILDFLYING>(arg0, 6, b"CHILDFLYING", b"Child at the window", x"4a656e69666665722043617374726f2077656e7420766972616c206f6e20736f6369616c206d65646961206166746572207265667573696e6720746f2073776170206865722073656174206f6e206120706c616e6520776974682061206368696c642e0a0a41667465722064656e79696e6720746865206d6f746865722773207265717565737420666f722068657220746f206769766520757020686572207365617420746f2068657220736f6e2c2074686520776f6d616e20726563656976656420737570706f7274206f6e20736f6369616c206d6564696120616e6420626563616d6520612063656c6562726974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_08_22_20_41_552bf386f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILDFLYING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILDFLYING>>(v1);
    }

    // decompiled from Move bytecode v6
}

