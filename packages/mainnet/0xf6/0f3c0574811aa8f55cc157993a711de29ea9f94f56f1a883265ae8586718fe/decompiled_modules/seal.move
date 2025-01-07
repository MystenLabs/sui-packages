module 0xf60f3c0574811aa8f55cc157993a711de29ea9f94f56f1a883265ae8586718fe::seal {
    struct SEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAL>(arg0, 9, b"SEAL", b"Seal the Pokemon", b"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sollicitudin tortor justo. Maecenas varius tristique est, in consectetur turpis dapibus quis. Aenean quis auctor lacus. Curabitur nec convallis sapien. Suspendisse rutrum ante in feugiat pellentesque. In aliquam magna a turpis maximus, iaculis malesuada diam porttitor. Praesent rhoncus venenatis tincidunt. Pellentesque finibus finibus bibendum. Nullam dignissim sit amet tellus sed fringilla. Aenean in orci ac erat volutpat pellentesque. Curabitur laoreet mi tortor, ac tempus arcu efficitur vel. Phasellus scelerisque elit nec ultricies ornare. Curabitur eget libero euismod odio pharetra gravida.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/69e68cb9e557bcbb113b5f27316dbe0eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

