module 0xc8254324ddb5cf0802dbe9afc452b27f7eb5ef417c7086b19f22cbd5e7e375ae::hopfsh {
    struct HOPFSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFSH>(arg0, 6, b"HOPFSH", b"Hop Fish", b"They say fish don't jump, I'm an exception.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GYRE_FIWAAA_4_Ke_Q_81268b78f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPFSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPFSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

