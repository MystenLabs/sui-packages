module 0xa1ffed6c6e4114be58fc658c125c233b3cc2c5fb049e6a8ef2c88183c4ca3614::rewinder {
    struct REWINDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: REWINDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REWINDER>(arg0, 6, b"Rewinder", b"THE REWINDER", b"let's travel together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Large_Logo_e4d6095dd8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REWINDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REWINDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

