module 0x67eae45d559529879658caa211df5764437bfabd0099ac358be410e587c67981::rlp {
    struct RLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RLP>(arg0, 9, b"RLP", b"Real Life Pepe", b"The origin story of Pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a014fe29cbfc61d954a58e8225d14c8dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

