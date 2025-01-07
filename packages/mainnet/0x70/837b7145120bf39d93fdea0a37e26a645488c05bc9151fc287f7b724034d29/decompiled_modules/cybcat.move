module 0x70837b7145120bf39d93fdea0a37e26a645488c05bc9151fc287f7b724034d29::cybcat {
    struct CYBCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBCAT>(arg0, 9, b"CYBCAT", b"cybercat coin", b"just a cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/94adf717c3ace826b7a235bf23fe63a0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CYBCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

