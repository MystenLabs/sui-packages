module 0x831ba60ff6d696976356a4741538bd875a5169e6190fb777d2e2532d2eb38f5b::ttf {
    struct TTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTF>(arg0, 9, b"TTf", b"cat", b"catu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b9ba762389557f47f73b16e0da13987eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

