module 0x1666bc95bfc698f8875adb21e900bbaab887e4eb8de8372da97b0cb15f8e2d8f::snc {
    struct SNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNC>(arg0, 6, b"SNC", b"Snake Coin", x"536e616b6520436f696e2063616e206265207573656420696e20646563656e7472616c697a6564207061796d656e742073797374656d732c206d616b696e67207472616e73616374696f6e732066617374657220616e6420696e646570656e64656e74206f6620747261646974696f6e616c2062616e6b73200a43616e20626520696e746567726174656420696e746f20652d636f6d6d6572636520706c6174666f726d73206f72207573656420617320612072657761726420746f6b656e20666f722075736572732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/9b4308e4-8784-40e9-8b53-b5c0bfff1a36.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

