module 0x46717b9dbd011db676de9fb23c71c28861ac35165b10ad353a0e73c2508db946::suijin {
    struct SUIJIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJIN>(arg0, 6, b"SUIJIN", b"Suijin Inu", b"DOGE WALKED, SHIBA RAN... NOW SUIJIN INU RIDES THE WAVE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739754672123.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIJIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

