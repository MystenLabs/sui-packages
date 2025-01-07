module 0x6ea99330e418f5be8d31fd8ac5c1a6ff9d8dadf31d72ee485030ba217468b642::keanu {
    struct KEANU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEANU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEANU>(arg0, 9, b"Keanu", b"Keanu the grey dog", b"Hello friends, I'm Keanu, the nicest 7k meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6096bbbb47e7dc73001b6fb96c1cbfacblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEANU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEANU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

