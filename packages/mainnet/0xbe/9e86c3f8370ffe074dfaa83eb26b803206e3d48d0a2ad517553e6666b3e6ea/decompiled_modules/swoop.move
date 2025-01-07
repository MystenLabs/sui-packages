module 0xbe9e86c3f8370ffe074dfaa83eb26b803206e3d48d0a2ad517553e6666b3e6ea::swoop {
    struct SWOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOOP>(arg0, 6, b"SWOOP", b"SWoop CTO", b"Swoop taken over by the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953819438.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWOOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

