module 0xdb475b8644e8cdf7762804003731815476da9faa819a4bac05e50620e4285e10::sdfbxc {
    struct SDFBXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFBXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFBXC>(arg0, 9, b"SDFBXC", b"ZXVAD", b"SD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/19f54089-778f-47d0-942c-6437a7d39850.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDFBXC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDFBXC>>(v1);
    }

    // decompiled from Move bytecode v6
}

