module 0x6b445ab8a116fdc6bbb51ee408668ec2f8617912334ae92c5fb301be90b6ef88::korp {
    struct KORP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KORP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KORP>(arg0, 6, b"KORP", b"Korp", b"Splash", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730985097126.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KORP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KORP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

