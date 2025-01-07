module 0xbbd538b3c4cba8d0288bff23d268f032f0c0948380f238a8d380708e49ee55ab::crik {
    struct CRIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRIK>(arg0, 6, b"CRIK", b"Sui Crik", b"Sui Crik is just a blue bear, nothing more", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_06_20_T191309_750_48aa12544d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

