module 0x71cb47e039696dc63f54a4270b3a26b716a0592052d1621dd3e171862ab84fb0::walon {
    struct WALON has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALON>(arg0, 9, b"WALON", b"WAL", b"WAL MAINNET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9259148e82777523f5faf86ad1eaa570blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

