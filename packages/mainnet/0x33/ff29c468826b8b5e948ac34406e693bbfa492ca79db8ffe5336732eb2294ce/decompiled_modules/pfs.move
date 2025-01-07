module 0x33ff29c468826b8b5e948ac34406e693bbfa492ca79db8ffe5336732eb2294ce::pfs {
    struct PFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PFS>(arg0, 6, b"PFS", b"Pump Fun Sui", b"Pump it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1155_c69f211a3f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

