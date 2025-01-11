module 0x5cbd3c4efa49160b692218ca9a98f3392358648b224cf3cfcdb4004371ab8391::subo {
    struct SUBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBO>(arg0, 6, b"Subo", b"Suiboo", x"224d656574207468652061646f7261626c6520626c756520656c657068616e742c20612073796d626f6c206f66206a6f7920616e6420776973646f6d2c20737072656164696e6720736d696c657320776974682069747320706c617966756c20636861726d20616e642067656e746c65207370697269742e205065726665637420666f7220616464696e67206120746f756368206f6620637574656e65737320746f20616e792070726f6a65637421220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014621_d92eac3727.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

