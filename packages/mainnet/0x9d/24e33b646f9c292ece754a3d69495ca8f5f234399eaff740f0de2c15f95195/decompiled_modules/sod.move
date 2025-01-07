module 0x9d24e33b646f9c292ece754a3d69495ca8f5f234399eaff740f0de2c15f95195::sod {
    struct SOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOD>(arg0, 6, b"Sod", b"Santa on dogs", b"Santa on dogs come", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000879418_56cac5da86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

