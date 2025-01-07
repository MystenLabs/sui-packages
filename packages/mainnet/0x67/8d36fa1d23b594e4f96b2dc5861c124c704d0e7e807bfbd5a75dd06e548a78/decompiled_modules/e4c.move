module 0x678d36fa1d23b594e4f96b2dc5861c124c704d0e7e807bfbd5a75dd06e548a78::e4c {
    struct E4C has drop {
        dummy_field: bool,
    }

    fun init(arg0: E4C, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<E4C>(arg0, 9, b"E4C", b"Ambrus Studio", b"The $E4C token, serving as the universal currency within the E4C gaming ecosystem known as E4Cverse. It is designed to satisfy the development needs of the E4C gaming ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ambrus.s3.amazonaws.com/E4C-tokenicon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<E4C>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<E4C>>(0x2::coin::mint<E4C>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<E4C>>(v2);
    }

    // decompiled from Move bytecode v6
}

