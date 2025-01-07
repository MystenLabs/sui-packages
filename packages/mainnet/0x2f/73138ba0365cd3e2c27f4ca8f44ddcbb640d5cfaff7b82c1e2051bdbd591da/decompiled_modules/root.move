module 0x2f73138ba0365cd3e2c27f4ca8f44ddcbb640d5cfaff7b82c1e2051bdbd591da::root {
    struct ROOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOT>(arg0, 6, b"ROOT", b"Rootlets", b"Rootardio.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rootlets_812a2b6180.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

