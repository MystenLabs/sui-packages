module 0xc0397881ed191fbd1d5d1a2ee405fcb4b46db9c8e58b27b2f64b852fdf84827a::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 9, b"Moon", b"MoonCoin", x"4d6f6f6e436f696e206973206e6f742061207363616d636f696e2e20546865726520617265206e6f206c6971756964697479207769746864726177616c73206f72207275672070756c6c73e280946a7573742062757920616e642073656c6c207769746820636f6e666964656e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/47a3bdd1db76a4278a682c865ab5825bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

