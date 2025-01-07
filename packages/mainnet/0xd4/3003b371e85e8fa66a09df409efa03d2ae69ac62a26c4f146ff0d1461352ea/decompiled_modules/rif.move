module 0xd43003b371e85e8fa66a09df409efa03d2ae69ac62a26c4f146ff0d1461352ea::rif {
    struct RIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIF>(arg0, 6, b"Rif", x"52c4b04624", x"74686520776f726d73206172652065766f6c76696e6720616e6420736f206973207468652067616d65206275742061726520796f7520616e6f6e3f0a0a75726f202b2072696620666c79206f6e206e6f762031350a0a646f6e2774206d69737320796f7572206368616e636520746f2062652061205068446567656e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731950624774.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

