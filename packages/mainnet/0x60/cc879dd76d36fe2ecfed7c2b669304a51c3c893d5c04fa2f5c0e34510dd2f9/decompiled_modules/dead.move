module 0x60cc879dd76d36fe2ecfed7c2b669304a51c3c893d5c04fa2f5c0e34510dd2f9::dead {
    struct DEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEAD>(arg0, 6, b"DEAD", b"deadpool SUI", b"deadpool on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_e66ad020bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

