module 0x8d21429606daef259c15fef59e10a706f865dc10badba51d43b6a2892621f7ea::aaaak47 {
    struct AAAAK47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAK47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAK47>(arg0, 6, b"AAAAK47", b"aaaAK47", b"CANT STOP WONT STOP SUITING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5778134308240868607_y_94bbc7e332.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAK47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAK47>>(v1);
    }

    // decompiled from Move bytecode v6
}

