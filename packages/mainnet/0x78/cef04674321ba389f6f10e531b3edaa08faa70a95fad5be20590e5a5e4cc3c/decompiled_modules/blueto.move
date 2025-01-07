module 0x78cef04674321ba389f6f10e531b3edaa08faa70a95fad5be20590e5a5e4cc3c::blueto {
    struct BLUETO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUETO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUETO>(arg0, 6, b"BLUETO", b"BLUETO SUI", x"4d65657420426c7565746f2c0a546865206f6e6c79206d656d65636f696e20796f7520676f747461206361746368210a5374726169676874206f757474612050616c6c657420546f776e2773204c61620a0a444f4e27542046554d424c45205448452024424c5545544f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3570_fda6cad510.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUETO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUETO>>(v1);
    }

    // decompiled from Move bytecode v6
}

