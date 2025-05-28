module 0xb83156ed9bb65789b096cbd976953b1ef39e890c66d006c397ba33ca1d5a0740::suipass {
    struct SUIPASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPASS>(arg0, 9, b"SuiPass", b"Sui Pass", b"To be Eligible to SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9222661221f4ce4b9e0a62fbd1feda02blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPASS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPASS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

