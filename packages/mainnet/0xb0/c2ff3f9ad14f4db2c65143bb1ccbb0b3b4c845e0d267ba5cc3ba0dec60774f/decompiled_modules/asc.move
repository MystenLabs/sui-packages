module 0xb0c2ff3f9ad14f4db2c65143bb1ccbb0b3b4c845e0d267ba5cc3ba0dec60774f::asc {
    struct ASC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASC>(arg0, 9, b"ASC", b"APPSUICOIN", b"best token u ever see", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fcf89dde7597b00d87cd5591da667033blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

