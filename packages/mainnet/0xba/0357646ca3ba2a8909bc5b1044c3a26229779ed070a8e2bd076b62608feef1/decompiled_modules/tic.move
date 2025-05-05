module 0xba0357646ca3ba2a8909bc5b1044c3a26229779ed070a8e2bd076b62608feef1::tic {
    struct TIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIC>(arg0, 9, b"TIC", b"Titanic", b"Titanic meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4960f7b22e91ee791a5ab29924fdccf8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

