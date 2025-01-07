module 0xae6a38cdbbf25e97241186a044523711c3eda9d9c02dc8fcf22a3c8d8469c95e::turbodogs {
    struct TURBODOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBODOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBODOGS>(arg0, 6, b"TurboDogs", b"Turbo Dogs", b"The Official Mascott of the Turbos.Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953665210.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBODOGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBODOGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

