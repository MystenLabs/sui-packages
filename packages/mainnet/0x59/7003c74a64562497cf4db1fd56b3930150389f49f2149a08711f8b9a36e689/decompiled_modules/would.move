module 0x597003c74a64562497cf4db1fd56b3930150389f49f2149a08711f8b9a36e689::would {
    struct WOULD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOULD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOULD>(arg0, 6, b"WOULD", b"WOULD SUI", b"I love this meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20241124111824_863c54b111.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOULD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOULD>>(v1);
    }

    // decompiled from Move bytecode v6
}

