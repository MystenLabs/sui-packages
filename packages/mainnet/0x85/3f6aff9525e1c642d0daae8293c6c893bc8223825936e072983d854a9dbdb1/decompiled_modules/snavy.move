module 0x853f6aff9525e1c642d0daae8293c6c893bc8223825936e072983d854a9dbdb1::snavy {
    struct SNAVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAVY>(arg0, 6, b"SNavy", b"SUINAVY", b"The first Navy force on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suinavylogo_1880bef9b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAVY>>(v1);
    }

    // decompiled from Move bytecode v6
}

