module 0x4bd2ea1a6f4773c3a997c5cf2a9e6dc98966a889a5e74e62389163dd7c153df7::mt {
    struct MT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MT>(arg0, 9, b"MT", b"matlittle", b"This is the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/85b0d2ccda00d8f111856269cf6d190eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

