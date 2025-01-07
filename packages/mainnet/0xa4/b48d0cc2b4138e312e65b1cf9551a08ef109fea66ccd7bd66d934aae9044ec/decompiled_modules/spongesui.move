module 0xa4b48d0cc2b4138e312e65b1cf9551a08ef109fea66ccd7bd66d934aae9044ec::spongesui {
    struct SPONGESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGESUI>(arg0, 9, b"SPONGEsui", b"SPONGE", x"4a75737420616e6f7468657220676f6f6420646179206f6e200a405375694e6574776f726b0a204f6365616e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bc892ff88b984985f84e723c5770c287blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPONGESUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGESUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

