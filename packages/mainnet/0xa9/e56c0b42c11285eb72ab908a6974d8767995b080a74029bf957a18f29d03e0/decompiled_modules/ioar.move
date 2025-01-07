module 0xa9e56c0b42c11285eb72ab908a6974d8767995b080a74029bf957a18f29d03e0::ioar {
    struct IOAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: IOAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IOAR>(arg0, 6, b"IOAR", b"InuOnARug Sui", b"InuOnaRug On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_155804_51b7bbdd07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IOAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IOAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

