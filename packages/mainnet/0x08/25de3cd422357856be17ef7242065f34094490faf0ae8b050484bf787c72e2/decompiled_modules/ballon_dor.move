module 0x825de3cd422357856be17ef7242065f34094490faf0ae8b050484bf787c72e2::ballon_dor {
    struct BALLON_DOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLON_DOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLON_DOR>(arg0, 9, b"BALLON_DOR", b"WHIP", b"Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5245d6fb-3f22-4097-b715-c3f3f96196c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLON_DOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALLON_DOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

