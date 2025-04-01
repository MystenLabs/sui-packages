module 0x5cc7f16e601975768eb8d6973ab01bbbd635e8df02a42472fa9d734b3ca77fbc::u5 {
    struct U5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: U5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<U5>(arg0, 9, b"U5", b"i67e", b"j76e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/25471b0cb6b5e8d894c59b84f45157e4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<U5>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<U5>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

