module 0xdeb1a3a29b01d918911918db8827d79ab38d381d3c2f8c3ef7b098dd519d7414::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUMP>(arg0, 9, b"LADS", b"Mysten Lads", b"Mysten Labs built Sui. The Lads built the meme. $LADS on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.suipump.org/icons/787d9ac67ceee4deaadba2ffec11e4d9.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPUMP>>(0x2::coin::mint<SUIPUMP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

