module 0x12052a5d5cd4180b890a4b45e7e93050b56e0e32df2b260118cabb865334a232::wjwnns {
    struct WJWNNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WJWNNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WJWNNS>(arg0, 9, b"WJWNNS", b"Wywjjw", b"Wndjsns", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/08d0de03-84da-44cd-82ab-60905bf02b17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WJWNNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WJWNNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

