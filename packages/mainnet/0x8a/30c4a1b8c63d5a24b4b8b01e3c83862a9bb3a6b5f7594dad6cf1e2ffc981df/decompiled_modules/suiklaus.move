module 0x8a30c4a1b8c63d5a24b4b8b01e3c83862a9bb3a6b5f7594dad6cf1e2ffc981df::suiklaus {
    struct SUIKLAUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKLAUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKLAUS>(arg0, 6, b"SUIKLAUS", b"Sui Klaus", x"546865206669727374204b4c415553206f6e2073756920424c4f434b434841494e2e0a546869732069736e2774206a75737420616e6f74686572206d656d65636f696e2c2074686973206973207468652077686f6c652066697368626f776c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000412499_a675a20e61.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKLAUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKLAUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

