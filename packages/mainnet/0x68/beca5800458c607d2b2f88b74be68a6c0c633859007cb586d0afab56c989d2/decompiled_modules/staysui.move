module 0x68beca5800458c607d2b2f88b74be68a6c0c633859007cb586d0afab56c989d2::staysui {
    struct STAYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAYSUI>(arg0, 6, b"STAYSUI", b"Stay Sui", b"Stay stay stay stay stay stay Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000070242_e5ab38e50e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

