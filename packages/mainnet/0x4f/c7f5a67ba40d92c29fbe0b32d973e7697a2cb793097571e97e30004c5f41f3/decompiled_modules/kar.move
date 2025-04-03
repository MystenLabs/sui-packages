module 0x4fc7f5a67ba40d92c29fbe0b32d973e7697a2cb793097571e97e30004c5f41f3::kar {
    struct KAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAR>(arg0, 9, b"KAR", b"KARAHA", b"1000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/367118bb50a89d0df32e335c72997f1bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

