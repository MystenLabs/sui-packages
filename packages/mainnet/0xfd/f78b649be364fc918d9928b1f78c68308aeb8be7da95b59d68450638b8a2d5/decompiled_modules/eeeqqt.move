module 0xfdf78b649be364fc918d9928b1f78c68308aeb8be7da95b59d68450638b8a2d5::eeeqqt {
    struct EEEQQT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEEQQT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEEQQT>(arg0, 9, b"Eeeqqt", b"LUcuy", b"Nicee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ecccba54aaacdb9a3b30db81f9b943ceblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EEEQQT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEEQQT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

