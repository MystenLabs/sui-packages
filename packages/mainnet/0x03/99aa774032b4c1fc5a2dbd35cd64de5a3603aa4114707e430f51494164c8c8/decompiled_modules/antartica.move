module 0x399aa774032b4c1fc5a2dbd35cd64de5a3603aa4114707e430f51494164c8c8::antartica {
    struct ANTARTICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTARTICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTARTICA>(arg0, 6, b"ANTARTICA", b"Sui Antartica", b"Chill out with Sui Antarctica! The coldest adventure on Sui, exploring the frozen wonders of a land untouched. Prepare for an icy journey like no other!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Antartica_1_09c3d2c938.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTARTICA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANTARTICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

