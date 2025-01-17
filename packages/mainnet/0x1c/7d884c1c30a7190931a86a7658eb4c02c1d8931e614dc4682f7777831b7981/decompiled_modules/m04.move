module 0x1c7d884c1c30a7190931a86a7658eb4c02c1d8931e614dc4682f7777831b7981::m04 {
    struct M04 has drop {
        dummy_field: bool,
    }

    fun init(arg0: M04, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M04>(arg0, 9, b"M04", b"MUN04", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/34b12e258da4b37efeac917433b46a3ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M04>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M04>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

