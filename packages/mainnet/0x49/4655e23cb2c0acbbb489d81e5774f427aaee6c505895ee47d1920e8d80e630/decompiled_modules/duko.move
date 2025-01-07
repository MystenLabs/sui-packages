module 0x494655e23cb2c0acbbb489d81e5774f427aaee6c505895ee47d1920e8d80e630::duko {
    struct DUKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKO>(arg0, 6, b"Duko", b"Duko Coin", b"Duko on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1204_432f7fa624.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

