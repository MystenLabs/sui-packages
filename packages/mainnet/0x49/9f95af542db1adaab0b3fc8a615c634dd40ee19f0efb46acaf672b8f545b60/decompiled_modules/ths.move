module 0x499f95af542db1adaab0b3fc8a615c634dd40ee19f0efb46acaf672b8f545b60::ths {
    struct THS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THS>(arg0, 6, b"THS", b"trest", b"maodkqodod", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1755423565811.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

