module 0x12b86f8b08d40a904e4e5c80f99b741771ed22ca32094847c4fc7e1f43b36940::stmaxa {
    struct STMAXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STMAXA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STMAXA>(arg0, 9, b"STMAXA", b"Stmax", b"Stma----SSSSSSSSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e960e70-d677-4e15-b637-e3c092e5ae55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STMAXA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STMAXA>>(v1);
    }

    // decompiled from Move bytecode v6
}

