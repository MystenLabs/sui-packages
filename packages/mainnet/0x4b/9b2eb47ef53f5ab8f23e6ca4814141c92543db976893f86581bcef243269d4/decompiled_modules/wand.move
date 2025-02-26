module 0x4b9b2eb47ef53f5ab8f23e6ca4814141c92543db976893f86581bcef243269d4::wand {
    struct WAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAND>(arg0, 9, b"WAND", b"WandermuremCoin", x"4372696164612070656c612066616dc3ad6c69612057616e6465726d7572656d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d969ab7437858993677fe7cc39a6b2d5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

