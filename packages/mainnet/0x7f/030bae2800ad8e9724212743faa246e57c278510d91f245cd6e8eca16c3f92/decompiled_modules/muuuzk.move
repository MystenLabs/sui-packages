module 0x7f030bae2800ad8e9724212743faa246e57c278510d91f245cd6e8eca16c3f92::muuuzk {
    struct MUUUZK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUUUZK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUUUZK>(arg0, 6, b"MUUUZK", b"Muzk", b"muzk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732479738967.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUUUZK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUUUZK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

