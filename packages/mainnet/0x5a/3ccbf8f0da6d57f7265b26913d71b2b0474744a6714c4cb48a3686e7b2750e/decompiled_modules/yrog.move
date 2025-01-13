module 0x5a3ccbf8f0da6d57f7265b26913d71b2b0474744a6714c4cb48a3686e7b2750e::yrog {
    struct YROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: YROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YROG>(arg0, 6, b"YROG", b"YrogOnSui", b"Welcome to $YROG, The new opcoming figure of sui network in 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000024231_81322c599f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

