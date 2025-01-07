module 0x8c506a812fbc0bfd74985136244ecff42153fbe65261d33aacd6d7feb08af04::suisage {
    struct SUISAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAGE>(arg0, 6, b"SUISAGE", b" SUISAGE", b"delicious SUISAGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730994601917.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISAGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

