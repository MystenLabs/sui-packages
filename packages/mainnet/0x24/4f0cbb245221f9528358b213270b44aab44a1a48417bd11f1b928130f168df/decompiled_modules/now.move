module 0x244f0cbb245221f9528358b213270b44aab44a1a48417bd11f1b928130f168df::now {
    struct NOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOW>(arg0, 9, b"now", b"now", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOW>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOW>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

