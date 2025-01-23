module 0x95da2477eca54c16b266847fbe96e7f85502b957522ecfa98f1de97564c8eedb::doki {
    struct DOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOKI>(arg0, 6, b"DOKI", b"Doki On Sui", b"Doki Just a Dog on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028553_94719c864c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

