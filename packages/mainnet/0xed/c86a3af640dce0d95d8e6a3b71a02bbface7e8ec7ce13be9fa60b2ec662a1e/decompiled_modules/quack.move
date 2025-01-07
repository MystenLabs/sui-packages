module 0xedc86a3af640dce0d95d8e6a3b71a02bbface7e8ec7ce13be9fa60b2ec662a1e::quack {
    struct QUACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUACK>(arg0, 6, b"QUACK", b"CALLDUCK", x"49276d20616c726561647920612073746172206f6e20496e7374612c20627574206e6f7720496d20726561647920746f206265636f6d6520612063727970746f206c6567656e64200a0a4c65747320736565206966207468652063727970746f207472656e63686572732061726520726561647920666f722024515541434b20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w_Z_Vk_RCQV_400x400_a735483804.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

