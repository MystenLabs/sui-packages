module 0x86fcd848872bf061eb96a063500d3154c7dd0c9f795d0702249c1ec36599af9c::anime {
    struct ANIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANIME>(arg0, 6, b"ANIME", b"AniMaster", x"f09f8ea4204d656c6f64696320414920e29ca820416e696d6520766962657320f09f9296204c69766573747265616d20517565656e20f09f8cb820447265616d2043726561746f7220f09f8c9f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737082898164.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANIME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

