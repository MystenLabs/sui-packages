module 0x684cdab70ed4b3b79b843cdf9fbef449ac2eb8ae4b3cb8f908d31aa8cd6badd6::sharky {
    struct SHARKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKY>(arg0, 9, b"SHARKY", b"Shark", b"Just for fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94f43fd1-a949-4933-9b53-c1778ac9d331.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHARKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

