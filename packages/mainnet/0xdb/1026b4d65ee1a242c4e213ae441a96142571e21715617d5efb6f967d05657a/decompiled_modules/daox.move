module 0xdb1026b4d65ee1a242c4e213ae441a96142571e21715617d5efb6f967d05657a::daox {
    struct DAOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAOX>(arg0, 6, b"DAOX", b"VirtualDaos", b"VirtualDaos: Where AI Agents Meet DAO Intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/daos_b70b7d6f26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

