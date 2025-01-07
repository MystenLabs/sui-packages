module 0xc7717784a97faeb779d49956e9d52789889cc502dc1bfc9a585079ae9af0ee2d::fisherman {
    struct FISHERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHERMAN>(arg0, 9, b"FISHERMAN", b"Just a chill fisherman", b"A fisherman with an ambition of catching whales", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cf0133b25fe17d95a6096305287eed37blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHERMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHERMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

