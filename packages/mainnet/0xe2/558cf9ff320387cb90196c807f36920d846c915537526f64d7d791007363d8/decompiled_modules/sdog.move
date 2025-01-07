module 0xe2558cf9ff320387cb90196c807f36920d846c915537526f64d7d791007363d8::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOG>(arg0, 9, b"SDOG", b"Smart Dog", b"Very smart dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1ae9c17f00a89adeb7df573977220a03blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

