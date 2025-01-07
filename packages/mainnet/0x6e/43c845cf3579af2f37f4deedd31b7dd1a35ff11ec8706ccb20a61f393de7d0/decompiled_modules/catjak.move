module 0x6e43c845cf3579af2f37f4deedd31b7dd1a35ff11ec8706ccb20a61f393de7d0::catjak {
    struct CATJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATJAK>(arg0, 6, b"CATJAK", b"CATJAK on SUI", b"CATJAK ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_07_30_04_30_24_9d099498ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

