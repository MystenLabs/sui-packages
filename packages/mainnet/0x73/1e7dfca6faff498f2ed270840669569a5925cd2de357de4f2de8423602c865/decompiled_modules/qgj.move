module 0x731e7dfca6faff498f2ed270840669569a5925cd2de357de4f2de8423602c865::qgj {
    struct QGJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: QGJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QGJ>(arg0, 9, b"Qgj", b"hyjsdy", b"tytrdj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3d2d836758d9ac2dfdc5214afd7b78e6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QGJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QGJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

