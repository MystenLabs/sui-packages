module 0xfd12da558660835698e443044e1a8e4b276b808fd64938a33bbaacbac12f9d70::jai {
    struct JAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAI>(arg0, 6, b"JAI", b"Jelly AI", x"5765e2809972652061626f757420746f204348414e4745205448452047414d452077697468207468652066697273742d6576657220414920746f6b656e20696e207468652065636f73797374656d212054686973206973206a7573742074686520626567696e6e696e670a0a5448452046555455524520535441525453204e4f5721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731006997695.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

