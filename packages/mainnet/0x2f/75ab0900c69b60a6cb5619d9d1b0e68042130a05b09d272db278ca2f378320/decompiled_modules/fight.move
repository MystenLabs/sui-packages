module 0x2f75ab0900c69b60a6cb5619d9d1b0e68042130a05b09d272db278ca2f378320::fight {
    struct FIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIGHT>(arg0, 6, b"FIGHT", b"FIGHT", b"Fight!Fight!Fight!For MAGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/Gxn7zKp8O983RfYvmkFGdBycrQLE6l6VqL0JwKUQ-d4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIGHT>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FIGHT>(&mut v2, 210000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIGHT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

