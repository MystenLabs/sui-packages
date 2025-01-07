module 0x37589d50f8d214db0c942f74e836e3d9d9dad46993343844a7fea6d22cd7fb61::duke {
    struct DUKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKE>(arg0, 6, b"DUKE", b"DOG DUKE", b"A creation from Matt Furie himself DOG DUKE is the coolest dog on the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730970334907.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

