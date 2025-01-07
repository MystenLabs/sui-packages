module 0x9dd806048cb1fa2a022ddf35e08899f8a8b1967615df02c4199f3526e2350196::suisei {
    struct SUISEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEI>(arg0, 6, b"SUISEI", b"Suisei", x"486f7368696d61636869205375697365692028292069732061204a6170616e657365207669727475616c20596f7554756265722e200a5375697365692069732061206d6f646573742c206d756c74692d74616c656e7465642073696e67657220616e64206173706972696e672069646f6c2077686f20697320616d6f6e6720746865206d6f7265206c6576656c2d686561646564206d656d62657273206f66205355492c2074686f7567682073686520616c736f206861732061206368696c646973682073747265616b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hoshimachi_Suisei_2019_Portrait_bcb30031b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

