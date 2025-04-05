module 0x8d53f5381973cc2cb77cbb8dda0bb39df80c809404e1a63e0501e8459888d1ea::qgd {
    struct QGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: QGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QGD>(arg0, 9, b"Qgd", b"szgj", b"tyhrtdj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/02f998907f39f9c81e62762abc4f3997blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QGD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QGD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

