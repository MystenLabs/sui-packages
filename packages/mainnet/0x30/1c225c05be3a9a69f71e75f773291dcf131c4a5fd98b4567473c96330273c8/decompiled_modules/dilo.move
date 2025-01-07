module 0x301c225c05be3a9a69f71e75f773291dcf131c4a5fd98b4567473c96330273c8::dilo {
    struct DILO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DILO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DILO>(arg0, 6, b"Dilo", b"armadilo", b"just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731074051923.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DILO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DILO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

