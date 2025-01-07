module 0x893d5df118884cfc42d85a72eb4178bcb13d0bc8ae3636fa43e820457dce1795::babysuimon {
    struct BABYSUIMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSUIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSUIMON>(arg0, 6, b"BabySuimon", b"Baby sui monster", b"LP already burn 100%", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004555_97be862583.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSUIMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSUIMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

