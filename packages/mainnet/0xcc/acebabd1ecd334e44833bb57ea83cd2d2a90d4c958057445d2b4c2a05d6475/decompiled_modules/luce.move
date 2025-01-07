module 0xccacebabd1ecd334e44833bb57ea83cd2d2a90d4c958057445d2b4c2a05d6475::luce {
    struct LUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCE>(arg0, 9, b"LUCE", b"Luce is the official mascot of the Catholic Church's", b"Luce is the official mascot of the Catholic Church's 2025 Jubilee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4b3d375e357bb1aac2d1a1f40e35ddcbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

