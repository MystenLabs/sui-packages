module 0x2545069f92151d656f015f748ef74a85842a32012a6a406a8e5f83e68acc756a::msui {
    struct MSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSUI>(arg0, 9, b"mUSD", b"mUSD", b"Metastable USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mstable.io/coins/msui.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

