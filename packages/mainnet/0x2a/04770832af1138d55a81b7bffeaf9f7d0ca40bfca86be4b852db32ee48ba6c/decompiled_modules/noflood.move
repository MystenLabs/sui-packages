module 0x2a04770832af1138d55a81b7bffeaf9f7d0ca40bfca86be4b852db32ee48ba6c::noflood {
    struct NOFLOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOFLOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOFLOOD>(arg0, 6, b"NOFLOOD", b"Prayer for Flood victims", b"Vietnam: Yagi typhoon death toll rises to 233 as more bodies found in areas hit by landslides and floods", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_08_103627_456e58530c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOFLOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOFLOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

