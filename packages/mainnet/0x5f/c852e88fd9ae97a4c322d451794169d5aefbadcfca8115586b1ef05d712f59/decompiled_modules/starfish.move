module 0x5fc852e88fd9ae97a4c322d451794169d5aefbadcfca8115586b1ef05d712f59::starfish {
    struct STARFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARFISH>(arg0, 6, b"STARFISH", b"suistarfish", x"412073746172666973682077616e646572696e6720696e20746865207365612c20616672616964206f66206265696e6720656174656e2062792062696720666973682e20235355492054473a2068747470733a2f2f742e6d652f73746172666973687375690a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/star_d8582cec6c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

