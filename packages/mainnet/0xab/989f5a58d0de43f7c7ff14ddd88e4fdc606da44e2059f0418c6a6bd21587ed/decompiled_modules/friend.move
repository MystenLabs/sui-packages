module 0xab989f5a58d0de43f7c7ff14ddd88e4fdc606da44e2059f0418c6a6bd21587ed::friend {
    struct FRIEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRIEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRIEND>(arg0, 6, b"Friend", b"Friendshipbtc", b"o grande amigao do btc e de voce", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1734722772724_facefcec19.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRIEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRIEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

