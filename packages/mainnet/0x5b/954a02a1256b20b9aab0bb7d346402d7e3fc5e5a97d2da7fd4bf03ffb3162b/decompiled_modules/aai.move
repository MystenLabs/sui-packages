module 0x5b954a02a1256b20b9aab0bb7d346402d7e3fc5e5a97d2da7fd4bf03ffb3162b::aai {
    struct AAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAI>(arg0, 9, b"AAI", b"Agent AI", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cece85f5526379713872b1c217e6124bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

