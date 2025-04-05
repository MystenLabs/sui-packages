module 0x406abd76652f71af03031cc5ca8d45ed33a44a7c935f9005180b7d02b885d154::emil {
    struct EMIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMIL>(arg0, 9, b"EMIL", b"Borewski", b"token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/91ed5d40762e28f98539179ad6245de8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

