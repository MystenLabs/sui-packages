module 0x9ac9005af7b5b12af7716d4d49c6baa574d5f9f828a5522fede0826de03025ab::blinkey {
    struct BLINKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLINKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLINKEY>(arg0, 6, b"Blinkey", b"Blinky", b"Bliney", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0001_f1006735c8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLINKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLINKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

