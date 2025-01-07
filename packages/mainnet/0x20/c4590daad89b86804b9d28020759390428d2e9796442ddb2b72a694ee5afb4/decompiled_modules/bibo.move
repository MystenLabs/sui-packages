module 0x20c4590daad89b86804b9d28020759390428d2e9796442ddb2b72a694ee5afb4::bibo {
    struct BIBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBO>(arg0, 9, b"BIBO", b"Bin Bong", b"Bin Bong are My Meow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/084ae629b3383114651f1e3e11861cc1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

