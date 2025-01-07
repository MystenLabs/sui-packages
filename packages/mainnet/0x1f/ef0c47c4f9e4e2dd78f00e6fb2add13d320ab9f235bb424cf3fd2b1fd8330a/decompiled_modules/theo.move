module 0x1fef0c47c4f9e4e2dd78f00e6fb2add13d320ab9f235bb424cf3fd2b1fd8330a::theo {
    struct THEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEO>(arg0, 9, b"THEO", b"Thestory", b"Story", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b18523ab-adc6-4670-bc13-2214840f341b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

