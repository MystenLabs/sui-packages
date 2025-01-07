module 0x66a87290c1efefc4cc52a77fa1bba80f51dba9424690b46b1eb1802095c233cb::suiwars {
    struct SUIWARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWARS>(arg0, 6, b"SUIWARS", b"SUI WARS", b"May the pump be with you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4zor_722312c50f.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

