module 0x9d599b0b6c9d6761358d6f3dfd8be0d9ff17150f8707f8b13c86a9b34bc7a7b1::suipiumguy {
    struct SUIPIUMGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIUMGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIUMGUY>(arg0, 6, b"SUIPIUMGUY", b"OPIUMGUY on SUI", b"OPIUMGUY is a decentralized meme coin built on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_Jqi2_S84_400x400_7c079a72b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIUMGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPIUMGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

