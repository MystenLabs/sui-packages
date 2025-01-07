module 0x2fa5bbe32d48adc80cc2ce329674cd777f069b13dbf6031e977f416d0a887cb1::orc {
    struct ORC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORC>(arg0, 6, b"ORC", b"ORC Sui", b"$ORC is juicy, rare, and packed with gains. Take a bite and savor the profits!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000353_ecce3fc6c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORC>>(v1);
    }

    // decompiled from Move bytecode v6
}

