module 0x185173e32811ac5aefd08a508a9b462bef3acca1d354ff9e8604bc858c4d6d1f::rusian {
    struct RUSIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSIAN>(arg0, 9, b"RUSIAN", b"Narok", b"Hae panei oniwi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bfea92e7-7614-409c-b7cd-4cd0ed52bc35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUSIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

