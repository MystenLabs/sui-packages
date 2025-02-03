module 0xc16b8661452cf8bce882930177e1136cb6329f860f0e52465dba3e25d5c56cde::flop {
    struct FLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOP>(arg0, 6, b"Flop", b"sui flop", b"BELIEVE IN FLOP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000170134_9c44322ac5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

