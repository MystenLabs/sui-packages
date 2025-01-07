module 0x37c278347aa263f604d94dc47c8cc8b0f55e7067111c30477e5c92dd3a7feca0::xavier {
    struct XAVIER has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAVIER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAVIER>(arg0, 6, b"XAVIER", b"Pakalu Papito", b"Hello SUI, I'm single!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pakalu_2c67c3bbc2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAVIER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XAVIER>>(v1);
    }

    // decompiled from Move bytecode v6
}

