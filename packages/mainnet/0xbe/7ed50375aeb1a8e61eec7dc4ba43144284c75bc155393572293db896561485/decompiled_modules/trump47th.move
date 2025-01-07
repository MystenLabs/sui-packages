module 0xbe7ed50375aeb1a8e61eec7dc4ba43144284c75bc155393572293db896561485::trump47th {
    struct TRUMP47TH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP47TH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP47TH>(arg0, 9, b"TRUMP47TH", b"Trump47", b"America President 47th", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9fc622d-c637-4267-a11b-09c44b7db022.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP47TH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP47TH>>(v1);
    }

    // decompiled from Move bytecode v6
}

