module 0xfab13da152e0aa2f90d04644a561cb0d524c864e152a726ae525325ce7e8e6bd::joshsui {
    struct JOSHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOSHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOSHSUI>(arg0, 6, b"JOSHSUI", b"JOSHU", b"JOSHU IS JOSH ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giphy_3496150036_2d5c47f1fd.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOSHSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOSHSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

