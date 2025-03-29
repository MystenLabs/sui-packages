module 0x12ca53e70266a32aafeb60e0f9e3ed3fa1828c5c1a4e128053575c406a121bce::ind {
    struct IND has drop {
        dummy_field: bool,
    }

    fun init(arg0: IND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IND>(arg0, 9, b"IND", b"India", b"A coin to represent India", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/78b6b7bc2e48e4d540b94d7e6403211fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

