module 0xc7eb51d823abcd3b44e46cb762cf414265fb41d7f3bf86b14149a66c2e7c90db::cyan {
    struct CYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYAN>(arg0, 6, b"Cyan", b"Cyan on Sui", b"We are here to bring awareness and mass adoption of the SUI Network by covering everything in SUI's color! (CYAN) #4DA2FF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730981904510.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CYAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

