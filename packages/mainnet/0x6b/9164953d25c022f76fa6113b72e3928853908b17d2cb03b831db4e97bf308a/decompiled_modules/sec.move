module 0x6b9164953d25c022f76fa6113b72e3928853908b17d2cb03b831db4e97bf308a::sec {
    struct SEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEC>(arg0, 9, b"SEC", b"Brian Brooks", b"2025 SEC Chairman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/186c4738a58abf7dac1138ea76df3d4eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

