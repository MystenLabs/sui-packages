module 0xc39423693b39ae9c6c7f587ad07c8bbe99b5bdbd4a7d5052a761355cd6bf3fc7::warlus {
    struct WARLUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARLUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARLUS>(arg0, 6, b"WARLUS", b"https://x.com/WalrusProtocol", b"Welcome to the next generation of data storage. Secure, efficient, and decentralized.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Cnn_5_Kz_C_400x400_3cd4427b18.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARLUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WARLUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

