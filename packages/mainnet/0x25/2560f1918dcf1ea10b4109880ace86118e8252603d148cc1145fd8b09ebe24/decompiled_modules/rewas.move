module 0x252560f1918dcf1ea10b4109880ace86118e8252603d148cc1145fd8b09ebe24::rewas {
    struct REWAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: REWAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REWAS>(arg0, 9, b"REWAS", b"sfdas", b"ssdfsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3b98632-4570-4024-80b4-908bebec7839.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REWAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REWAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

