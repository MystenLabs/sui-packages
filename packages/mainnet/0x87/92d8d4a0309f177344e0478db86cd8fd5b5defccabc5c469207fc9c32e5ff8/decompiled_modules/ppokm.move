module 0x8792d8d4a0309f177344e0478db86cd8fd5b5defccabc5c469207fc9c32e5ff8::ppokm {
    struct PPOKM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPOKM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPOKM>(arg0, 6, b"PPOKM", b"Probably Pokemon", b"Probably pokemon ! from  community to the  community !  let's go  ! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746662662455.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPOKM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPOKM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

