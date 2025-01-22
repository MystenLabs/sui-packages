module 0x6220de5f473b104f656eb2eab6643466c8aea4d28f87b6b08ddb50cbb74bda1a::trenchor {
    struct TRENCHOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCHOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRENCHOR>(arg0, 9, b"Trenchor", b"TrenchorAI", b"ephemeral", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ca807ec5e4eefb44769cb2753280dcdfblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRENCHOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCHOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

