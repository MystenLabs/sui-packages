module 0xd7053c028fbe7b46c4e00cd7d14d5d9e0a483d852b7199ff6d95e7c2b98ffcb1::jobs {
    struct JOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOBS>(arg0, 6, b"JOBS", b"Steve Jobs", x"50656f706c652061736b206d65207768617420696e6e6f766174696f6e2069732e0a4974e2809973206e6f742061626f757420746563686e6f6c6f67792e0a4974e2809973206e6f742061626f7574206d6f6e65792e0a4974e28099732061626f75742062656c6965662e0a0a42656c696576696e67207468617420796f752063616e206368616e67652074686520776f726c6420e2809420616e642061637475616c6c7920646f696e672069742e0a0a5468696e6b20446966666572656e742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747766654435.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOBS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOBS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

