module 0xf23be0636e048335298c9b19423bd12677bfd45eb4f8d171eddf7ce47e93559d::rintaro {
    struct RINTARO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RINTARO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RINTARO>(arg0, 9, b"RINTARO", b"Rintaro", b"Rintaro on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/511faffc-91d6-4e5c-85b1-959e53f42837.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RINTARO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RINTARO>>(v1);
    }

    // decompiled from Move bytecode v6
}

