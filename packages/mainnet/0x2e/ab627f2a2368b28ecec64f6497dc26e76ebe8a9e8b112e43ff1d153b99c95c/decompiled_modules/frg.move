module 0x2eab627f2a2368b28ecec64f6497dc26e76ebe8a9e8b112e43ff1d153b99c95c::frg {
    struct FRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRG>(arg0, 6, b"FRG", b"HopFrog", b"HopFrogSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954912118.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

