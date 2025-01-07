module 0x463bc18a557f9c9c6257012e55abe9ead6ac68db415b00576b5b2ee6469e21ac::rakki {
    struct RAKKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAKKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAKKI>(arg0, 6, b"RAKKI", b"Rakki Cat Relaunch", x"4166746572207468652070726576696f757320646576656c6f7065722065786974656420746865204d6f76652050756d702070726f6a6563742c2049207374657070656420696e2061732043544f2e204e6f772c20697427732074696d6520746f2072656c61756e636820746869732070726f6a6563742e205468616e6b7320746f20547572626f732046756e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730437824782.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAKKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAKKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

