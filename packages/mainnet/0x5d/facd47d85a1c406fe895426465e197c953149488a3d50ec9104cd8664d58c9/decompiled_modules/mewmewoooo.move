module 0x5dfacd47d85a1c406fe895426465e197c953149488a3d50ec9104cd8664d58c9::mewmewoooo {
    struct MEWMEWOOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWMEWOOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWMEWOOOO>(arg0, 9, b"MEWmewoooo", b"mew", b"mew in dogs world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8b891fdba023804d765c62f1d701806ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEWMEWOOOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWMEWOOOO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

