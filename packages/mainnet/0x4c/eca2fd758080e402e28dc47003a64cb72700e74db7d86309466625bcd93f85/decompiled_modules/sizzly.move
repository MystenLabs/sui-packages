module 0x4ceca2fd758080e402e28dc47003a64cb72700e74db7d86309466625bcd93f85::sizzly {
    struct SIZZLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIZZLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIZZLY>(arg0, 6, b"SIZZLY", b"SUIZZLY", b"Dive into the sweetest corner of the SUI chain $SIZZLY the chubby bear on a mission for endless honey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_80637941a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIZZLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIZZLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

