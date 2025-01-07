module 0x376ddacade492f86b2dad0e5b344b680dad78abf510cd03a8356e6d029489907::thes {
    struct THES has drop {
        dummy_field: bool,
    }

    fun init(arg0: THES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THES>(arg0, 6, b"Thes", b"Yshwn ", b"Hsbssb shahs whhsbs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953026452.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

