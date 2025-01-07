module 0x616ed364211d5ecb1355b0ca3203c499cdc3d5b739ad586769ebf4420e2bc9a9::psn {
    struct PSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSN>(arg0, 6, b"PSN", b"PepeSnowman", b"Pepe The Snowman is a revolutionary coin set to take the world by Snow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053411_92b02619f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

