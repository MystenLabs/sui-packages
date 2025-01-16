module 0xc32fd46691b3fc91f66b14ed396e5582a6a8d6ac9adaf1197805a895839c5d52::hemp {
    struct HEMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEMP>(arg0, 6, b"HEMP", b"Hemp Coin", b"Hemp is memecoin dedicated to raising awareness and promoting the sustainble cultivation and utilization of industrial hemp.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737029877983.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

