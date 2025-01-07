module 0xfd2e2b79cf31dfe8f3f24590db5040a5add3983ff5a3fd9e5a887cb033374a6d::sanics {
    struct SANICS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANICS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANICS>(arg0, 6, b"SANICS", b"Sanic on SUI", x"53616e69632063616e2072756e20757020746f2031322074696d657320746865207370656564206f66206c696768742c20616e642063616e2074726176656c20757020746f20382c3034372c3339392c353438206d706820696e20686973206261736520666f726d207768696368206973203130206d696c6c696f6e2074696d6573206173206661737420636f6d706172656420746f20536f6e69632061732068652063616e206f6e6c792072756e20757020746f20373630206d70682e0a0a52756e20746f20627579202453414e49435320464952535421212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gif_perfil_2_af97936b6c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANICS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANICS>>(v1);
    }

    // decompiled from Move bytecode v6
}

