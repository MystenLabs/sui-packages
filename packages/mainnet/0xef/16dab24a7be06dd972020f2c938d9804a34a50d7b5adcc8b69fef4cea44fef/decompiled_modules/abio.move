module 0xef16dab24a7be06dd972020f2c938d9804a34a50d7b5adcc8b69fef4cea44fef::abio {
    struct ABIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABIO>(arg0, 9, b"ABIO", b"Adeniyi", b"CEO of Sui Memes. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5fd2eb2dd12b350cddb2ae1cb3fcedddblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABIO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

