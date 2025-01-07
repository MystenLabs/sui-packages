module 0xbb8cbecc5467a1e8dec8bdfcef66b12ec8ac84f0e5c84b4ca86449fa931ee008::odinsui {
    struct ODINSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODINSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODINSUI>(arg0, 6, b"Odinsui", b"Odin Sui", b"just community project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050346_0854aee1f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODINSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODINSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

