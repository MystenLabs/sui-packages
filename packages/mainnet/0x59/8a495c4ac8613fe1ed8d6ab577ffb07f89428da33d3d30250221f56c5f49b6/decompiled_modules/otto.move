module 0x598a495c4ac8613fe1ed8d6ab577ffb07f89428da33d3d30250221f56c5f49b6::otto {
    struct OTTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTO>(arg0, 9, b"OTTO", b"otobrazhaika", b"new token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0707ab1f3dba827cbbd46efb7a2b22dbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

