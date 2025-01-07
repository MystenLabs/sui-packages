module 0x9af7b82d5c6bf45f8d4457ed3419cd42ed7dc4d4b833d4e8146546ace4165b9e::tr20th {
    struct TR20TH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TR20TH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TR20TH>(arg0, 6, b"TR20TH", b"TRUMP20TH", b"Simply Trump on the 20th when he becomes president", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735461924030.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TR20TH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TR20TH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

