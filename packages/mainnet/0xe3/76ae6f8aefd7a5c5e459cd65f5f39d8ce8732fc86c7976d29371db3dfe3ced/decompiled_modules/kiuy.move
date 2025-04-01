module 0xe376ae6f8aefd7a5c5e459cd65f5f39d8ce8732fc86c7976d29371db3dfe3ced::kiuy {
    struct KIUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIUY>(arg0, 9, b"KIUY", b"yuk", b"U7RI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/211f528e4e001c7c7a6b97672edab1dablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIUY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

