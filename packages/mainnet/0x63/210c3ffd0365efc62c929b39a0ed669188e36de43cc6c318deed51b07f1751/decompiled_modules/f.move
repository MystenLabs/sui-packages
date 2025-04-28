module 0x63210c3ffd0365efc62c929b39a0ed669188e36de43cc6c318deed51b07f1751::f {
    struct F has drop {
        dummy_field: bool,
    }

    fun init(arg0: F, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<F>(arg0, 9, b"F", b"gf", b"G", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8108c9930d409b96d142dff9330e6f76blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<F>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

