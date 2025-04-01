module 0x46835488cc1be0e260ada2f7482ad26bbba2f858bc0406e39d12d1b2865ad78::fiyuo {
    struct FIYUO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIYUO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIYUO>(arg0, 9, b"FIYUO", b"yiuk", b"7o", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cca64bf1afa2d4ea690f459cab52a9b7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIYUO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIYUO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

