module 0x7de151dbff307084c55566aa42ccd6047feef83f5a1f0501a143190b3eebfe74::teeth {
    struct TEETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEETH>(arg0, 6, b"TEETH", b"TurkTeeth", b"Let's all get that $ and go get a brand new smile!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1754265241828.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEETH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEETH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

