module 0xdffb4a5b93bd39fa3697362151cf4234d22e60584ff4ce4a6ae01e90cd4a5877::catholic {
    struct CATHOLIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATHOLIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATHOLIC>(arg0, 6, b"CATHOLIC", b"Catholic", b"Faith of the degens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image02_cea2aa8242.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATHOLIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATHOLIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

