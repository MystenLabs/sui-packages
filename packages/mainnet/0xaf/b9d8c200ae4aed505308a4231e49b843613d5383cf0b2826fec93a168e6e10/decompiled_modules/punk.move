module 0xafb9d8c200ae4aed505308a4231e49b843613d5383cf0b2826fec93a168e6e10::punk {
    struct PUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNK>(arg0, 6, b"PUNK", b"punk punk", b"Punk is a good thing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748845130422.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUNK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

