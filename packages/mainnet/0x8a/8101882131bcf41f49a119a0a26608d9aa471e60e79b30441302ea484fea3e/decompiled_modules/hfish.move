module 0x8a8101882131bcf41f49a119a0a26608d9aa471e60e79b30441302ea484fea3e::hfish {
    struct HFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFISH>(arg0, 6, b"HFISH", b"Hop Fish", b"They say fish don't jump, I'm an exception.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GYRE_FIWAAA_4_Ke_Q_81268b78f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

