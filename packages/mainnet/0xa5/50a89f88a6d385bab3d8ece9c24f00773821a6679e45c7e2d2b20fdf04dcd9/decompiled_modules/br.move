module 0xa550a89f88a6d385bab3d8ece9c24f00773821a6679e45c7e2d2b20fdf04dcd9::br {
    struct BR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BR>(arg0, 9, b"Br", b"bragno", b"bragno is a historical meme coin of a real historie berfore bilion years in a world of fantasy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/54bcdaddc1b8cbbf8d841ab69fe64946blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

