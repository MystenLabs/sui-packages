module 0xffe0a596c081a15724c254cc60a06bc02c36ae2fdfd674b7f94239d9a0c06ce2::pollard {
    struct POLLARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLLARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLLARD>(arg0, 9, b"POLLARD", x"f09d908ff09d90a8f09d90a5f09d90a5f09d909af09d90abf09d909d27f09d909220f09d9088f09d90a6f09d90a9f09d90aef09d90a5f09d90acf09d90a2f09d90aff09d909e20f09d908ff09d90a8f09d90a2f09d90acf09d90a8f09d90a7", x"f09281a3f09285adea8da5e9a9ace595a4e9b5b4f09385a9e99ca0e999acea89a3e99ca0e9a9acf09385b3e9a5a5e9aca0f09381aff0938db4e999aee9a9b4e9b8a0f09285adf09281b2e9a9b6e9a9adf09389aee9b4a0ea95a9e9a0a0f09389b5e9b9b4e9b1aee998a0e9a5a420e9a5a5ea8ca0f09389a1e9a9b4e595b2e9b9b0ea89a3e9aca0e9b9ace9b5a7e595b4f09381afe9a9a4f09385b2f09284a0e999acf09099a9e9b0a0e999b2e9b9b4f0938db4e9a9a4e9a4a0f09381a9e9a1a5e595b4e9a9a2e999a3f09385b5e595a5e9a9b2f0938db4f09099b2e9a4a0f09385a5e9b9b4e9a9aee595a4f09099a920ea8da3e9a5b5f09099a9e595a7e9a9a6e595b7f09389a9", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ea75f27790563a199609154cba0218b1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POLLARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLLARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

