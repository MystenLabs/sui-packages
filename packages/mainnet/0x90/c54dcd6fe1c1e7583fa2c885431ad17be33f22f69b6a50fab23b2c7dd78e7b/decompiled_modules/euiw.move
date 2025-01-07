module 0x90c54dcd6fe1c1e7583fa2c885431ad17be33f22f69b6a50fab23b2c7dd78e7b::euiw {
    struct EUIW has drop {
        dummy_field: bool,
    }

    fun init(arg0: EUIW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EUIW>(arg0, 6, b"Euiw", b"Euiwlonmask", x"546f20746865204d6f6f6e20616e64204265796f6e64e28094576974682022457569776c6f6e6d61736b22204c656164696e6720746865205761792021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953089167.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EUIW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EUIW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

