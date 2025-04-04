module 0xeb4e239f67da486f58caa4f7f89ca17fa471eb495750ba2199189f457d6de96::kc {
    struct KC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KC>(arg0, 9, b"Kc", b"kcore83", b"make you rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0db1af1db276819784b6fe0006a237acblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

