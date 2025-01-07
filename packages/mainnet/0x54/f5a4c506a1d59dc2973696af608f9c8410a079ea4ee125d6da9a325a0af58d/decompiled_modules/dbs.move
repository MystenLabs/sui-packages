module 0x54f5a4c506a1d59dc2973696af608f9c8410a079ea4ee125d6da9a325a0af58d::dbs {
    struct DBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBS>(arg0, 6, b"DBS", b"Dragon Ball Z Sui", x"57697468207468652068656c70206f662074686520706f77657266756c20447261676f6e62616c6c732c2061207465616d206f66206669676874657273206c6564206279207468652073616979616e2077617272696f7220476f6b7520646566656e642074686520706c616e65742065617274682066726f6d206578747261746572726573747269616c20656e656d6965732e0a0a4261736564206f6e20616e696d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000617_2e85c20a54.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

