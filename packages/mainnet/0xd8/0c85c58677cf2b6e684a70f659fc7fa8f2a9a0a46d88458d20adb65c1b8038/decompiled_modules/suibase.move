module 0xd80c85c58677cf2b6e684a70f659fc7fa8f2a9a0a46d88458d20adb65c1b8038::suibase {
    struct SUIBASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBASE>(arg0, 6, b"SUIBASE", b"Sui Base", b"THE GATEWAY TO MARS BY SUIX AEROSPACE, FOUNDED BY MYSTEN LABS. DONT BLINK WE WILL BLAST OFF! ONCE WE ONBOARD WHALES.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6163_09765fe90a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBASE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBASE>>(v1);
    }

    // decompiled from Move bytecode v6
}

