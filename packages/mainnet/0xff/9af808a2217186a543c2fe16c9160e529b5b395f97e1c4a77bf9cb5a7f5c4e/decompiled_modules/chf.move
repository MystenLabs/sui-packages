module 0xff9af808a2217186a543c2fe16c9160e529b5b395f97e1c4a77bf9cb5a7f5c4e::chf {
    struct CHF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHF>(arg0, 6, b"CHF", b"CTOHOPFUN", b"NEVER LAUNCHING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/leo_django_laughing_bb41db927d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHF>>(v1);
    }

    // decompiled from Move bytecode v6
}

