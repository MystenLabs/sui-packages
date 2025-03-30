module 0xef80576e8ca110709e50a4cb418cccf1551828dbaa8faca9e93220b389a5ea15::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG>(arg0, 9, b"DOG", b"DOG from BTC", b"Best meme on Bitcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/71b38b8e02febea9e151440a2cf64d51blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

