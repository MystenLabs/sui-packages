module 0x7b76b7f6e01598bdc276f05a079a7935f5a8d98edc00b7bcb48acc6e6a18bc3b::rowlet {
    struct ROWLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROWLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROWLET>(arg0, 6, b"ROWLET", b"ROWLET SUI", b"Relaunch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigmneuyzvnbiist65fxdytnz7rvupgdxazu3odsxsntjslovhgkk4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROWLET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROWLET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

