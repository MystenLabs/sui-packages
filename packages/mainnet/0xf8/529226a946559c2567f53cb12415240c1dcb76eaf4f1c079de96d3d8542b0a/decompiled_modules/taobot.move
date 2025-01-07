module 0xf8529226a946559c2567f53cb12415240c1dcb76eaf4f1c079de96d3d8542b0a::taobot {
    struct TAOBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAOBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAOBOT>(arg0, 6, b"TAOBOT", b"tao.bot", b"Make the Bittensor Ecosystem your Playground with $TAOBOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Taobot_35018da066.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAOBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAOBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

