module 0xd0a4c9104c1b1fd158463bd35bb3046926f0963fdc59680d0cafc4f37cad8b7f::gerry {
    struct GERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GERRY>(arg0, 6, b"GERRY", b"Gerry On Sui", b"ack in the cryptosphere with $GERRY .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001956_e398e95b31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

