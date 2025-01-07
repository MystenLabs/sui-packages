module 0x9abd1809cef6abc0d83375098938d88d47da7141971aa0d4df18ea8f5d8092fc::dopin {
    struct DOPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPIN>(arg0, 9, b"DOPIN", b"Dopin", x"43c3a12068656f2073e1bb916e6720646169206e68c6b020c491c4a961", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5ac3df3b-283b-4afc-b2ef-ec143e9cf3e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

