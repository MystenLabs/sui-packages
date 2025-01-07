module 0xe55ca12f6bc3bf869f6d57f9d795ccf94fe25035a9ec4233324dbfbb9fdfc167::jkhg {
    struct JKHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JKHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JKHG>(arg0, 9, b"JKHG", b"ASDAS", b"VBCCD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3189d39d-5972-4483-9d10-a000f4760503.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JKHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JKHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

