module 0xa75326d5d215f6e30539e03926d8a811bb453848ea9a7aa78170ddd492856bef::suimehcoin {
    struct SUIMEHCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEHCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEHCOIN>(arg0, 6, b"SUIMEHCOIN", b"SUIMEH", x"245355494d454820e280942074686520656d626f64696d656e74206f662061706174687920696e20746865206d656d6520636f696e20756e6976657273652c2074686520756c74696d6174652063727970746f20646567656e2c20656d6f74696f6e6c65737320696e207468652066616365206f66206368616f732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731331683797.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEHCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEHCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

