module 0x18b7565feee01098950984b29112a6ae63cfc90b808e8e8e20be114520eec337::bvpn {
    struct BVPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BVPN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVPN>(arg0, 6, b"bVPN", b"blueVPN", b"Access a world of Web3 opportunities securely with a single sign-in.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_17_00_42_42_516d0d0fb7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BVPN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BVPN>>(v1);
    }

    // decompiled from Move bytecode v6
}

