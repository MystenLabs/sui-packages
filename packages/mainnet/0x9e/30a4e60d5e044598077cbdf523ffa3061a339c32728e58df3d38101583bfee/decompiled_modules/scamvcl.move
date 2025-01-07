module 0x9e30a4e60d5e044598077cbdf523ffa3061a339c32728e58df3d38101583bfee::scamvcl {
    struct SCAMVCL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAMVCL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAMVCL>(arg0, 9, b"SCAMVCL", b"Scam", b"Scam vclonnnn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9cc0dc9929dfe320972215b974a2aaa8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCAMVCL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAMVCL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

