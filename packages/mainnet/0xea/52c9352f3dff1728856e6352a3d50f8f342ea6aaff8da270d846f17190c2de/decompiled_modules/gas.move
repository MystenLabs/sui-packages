module 0xea52c9352f3dff1728856e6352a3d50f8f342ea6aaff8da270d846f17190c2de::gas {
    struct GAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAS>(arg0, 9, b"Gas", b"gangstashef", b"100", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7c6a7190f5e5adbc0ffa129220df0f4fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

