module 0x6fda30223b6d98996dd436adab1ff0b2492069705929214c8cae40660122605e::seal {
    struct SEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAL>(arg0, 9, b"SEAL", b"Seal the Pokemon", b"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sollicitudin tortor justo. Maecenas varius tristique est, in consectetur turpis dapibus quis. Aenean quis auctor lacus. Curabitur nec convallis sapien. Suspendisse rutrum ante in feugiat pellentesque. In aliquam magna a turpis maximus, iaculis malesuada diam porttitor. Praesent rhoncus venenatis tincidunt. Pellentesque finibus finibus bibendum. Nullam dignissim sit amet tellus sed fringilla. Aenean in orci ac erat volutpat pellentesque. Curabitur laoreet mi tortor, ac tempus arcu efficitur vel. Phasellus scelerisque elit nec ultricies ornare. Curabitur eget libero euismod odio pharetra gravida.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/70bf957654af1962f8e627d5d084913bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

