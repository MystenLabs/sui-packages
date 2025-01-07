module 0x4c422a8e50015317f39386eaed8d4de29c9c2022c1de39f9f45a00a27cac11ae::moge {
    struct MOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOGE>(arg0, 9, b"MOGE", b"Meta Doge", x"4d657461446f67652069732061206d656d652d706f776572656420746f6b656e206f6e205375692c20626c656e64696e6720446f6765e280997320636861726d207769746820746865206d65746176657273652e20497420666f6375736573206f6e204465466920616e64204e4654732c206f66666572696e6720666173742c206c6f772d636f7374207472616e73616374696f6e732077697468696e20612066756e2c206d656d652d64726976656e2065636f73797374656d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1481875359469834244/baria2Nn.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOGE>(&mut v2, 4000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

