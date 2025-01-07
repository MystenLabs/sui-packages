module 0x44dbad853538abd119e2ec32c8194c985557d6d57a32967584639716ebfced22::kendu {
    struct KENDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENDU>(arg0, 6, b"Kendu", b"Kendu-Inu", x"554e4954494e472054484520534958204e4154495645204a4150414e45534520444f4720425245454453204f4e20535549210a0a4b656e647520697320746865206e61727261746976652c20616e6420796f75206172652074686520636174616c7973742e204265636f6d6520746865206d61696e2063686172616374657220696e207468652072697365206f662074686520756c74696d617465206d656d65636f696e2065636f73797374656d2e2057696c6c20796f75206a6f696e20746865207061636b3f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KENDU_8db010d7ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENDU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KENDU>>(v1);
    }

    // decompiled from Move bytecode v6
}

