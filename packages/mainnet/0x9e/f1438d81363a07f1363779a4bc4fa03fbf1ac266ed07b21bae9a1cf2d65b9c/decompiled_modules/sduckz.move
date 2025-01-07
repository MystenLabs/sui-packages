module 0x9ef1438d81363a07f1363779a4bc4fa03fbf1ac266ed07b21bae9a1cf2d65b9c::sduckz {
    struct SDUCKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDUCKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDUCKZ>(arg0, 6, b"SDUCKZ", b"SUI DUCKZ", x"68747470733a2f2f6c696e6b74722e65652f7375696475636b7a0a0a4455434b5a204f4e205355492c204e4654202c204d494e542c204441505053", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3616_3748e905cb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDUCKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDUCKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

