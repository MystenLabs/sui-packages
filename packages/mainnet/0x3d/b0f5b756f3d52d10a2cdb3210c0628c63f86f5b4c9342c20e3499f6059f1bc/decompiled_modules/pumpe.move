module 0x3db0f5b756f3d52d10a2cdb3210c0628c63f86f5b4c9342c20e3499f6059f1bc::pumpe {
    struct PUMPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPE>(arg0, 6, b"PUMPE", b"Pumpe On Sui", b"PUMPE - The only way is up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000755_24dd45849c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

