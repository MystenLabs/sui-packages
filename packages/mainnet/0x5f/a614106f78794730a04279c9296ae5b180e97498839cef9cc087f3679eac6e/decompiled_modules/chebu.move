module 0x5fa614106f78794730a04279c9296ae5b180e97498839cef9cc087f3679eac6e::chebu {
    struct CHEBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEBU>(arg0, 6, b"CHEBU", b"CHEBUBEAR", b"$CHEBU CULT IS LOOKING FOR A FRESH BLOOD!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5481_3803f28044.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

