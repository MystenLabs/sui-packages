module 0x4eb0a10ba01095bcfcdb85dca4b6559da6f77f4630ffa73724663d77ac06161d::blfish {
    struct BLFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLFISH>(arg0, 6, b"BLFISH", b"Black Fish", b"BLACKFISH $BLFISH Welcome, traveler of the SUI Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730961887242.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLFISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLFISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

