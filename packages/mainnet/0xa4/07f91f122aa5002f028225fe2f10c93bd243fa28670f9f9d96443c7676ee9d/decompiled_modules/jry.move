module 0xa407f91f122aa5002f028225fe2f10c93bd243fa28670f9f9d96443c7676ee9d::jry {
    struct JRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JRY>(arg0, 9, b"Jry", b"jarry", b"a good dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ea0c52f6a7f82729530105e3b9b4ff5fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

