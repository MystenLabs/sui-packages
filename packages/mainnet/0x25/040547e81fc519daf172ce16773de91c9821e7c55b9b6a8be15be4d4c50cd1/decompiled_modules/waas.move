module 0x25040547e81fc519daf172ce16773de91c9821e7c55b9b6a8be15be4d4c50cd1::waas {
    struct WAAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAAS>(arg0, 6, b"WAAS", b"waas", b"we are all Satoshi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WX_20241008_024607_2x_015a9128e5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

