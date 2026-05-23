module 0xf2022b92053754808432968bcea1809e31ed328b2267528396b63748f6e50f74::swd {
    struct SWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWD>(arg0, 6, b"SWD", b"SIGMAWARD", b"Sigma ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1779495754285.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

