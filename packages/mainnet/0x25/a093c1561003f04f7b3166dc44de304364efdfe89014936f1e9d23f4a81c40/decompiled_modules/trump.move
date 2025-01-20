module 0x25a093c1561003f04f7b3166dc44de304364efdfe89014936f1e9d23f4a81c40::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"Trump SUI", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images20_3612ae6ceb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

