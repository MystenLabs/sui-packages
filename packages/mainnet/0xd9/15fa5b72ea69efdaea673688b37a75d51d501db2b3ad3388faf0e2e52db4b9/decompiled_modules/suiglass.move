module 0xd915fa5b72ea69efdaea673688b37a75d51d501db2b3ad3388faf0e2e52db4b9::suiglass {
    struct SUIGLASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGLASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGLASS>(arg0, 6, b"Suiglass", b"$SuiGlass", b"Watch my way to the moon with glasses", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000107239_82ca74691e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGLASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGLASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

