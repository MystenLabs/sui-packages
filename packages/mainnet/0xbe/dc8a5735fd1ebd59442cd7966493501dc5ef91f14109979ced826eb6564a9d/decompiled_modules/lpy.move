module 0xbedc8a5735fd1ebd59442cd7966493501dc5ef91f14109979ced826eb6564a9d::lpy {
    struct LPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPY>(arg0, 9, b"LPY", b"Loopy", b"Loopy in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/ce9f32d6cecd8e6ca6ed5840425de034blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

