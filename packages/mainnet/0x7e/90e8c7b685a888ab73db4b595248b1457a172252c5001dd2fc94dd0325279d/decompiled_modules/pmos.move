module 0x7e90e8c7b685a888ab73db4b595248b1457a172252c5001dd2fc94dd0325279d::pmos {
    struct PMOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMOS>(arg0, 6, b"PMOS", b"PacManOnSui", b"Prepare yourself for an adventure full of surprises with PacMan!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logog_3ea2427a19.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PMOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

