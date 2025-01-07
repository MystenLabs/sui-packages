module 0x755e5b1222c52d0ff726fff65aea3611415a61c5c3c42473b68a8db316dbfd01::ketama {
    struct KETAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KETAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KETAMA>(arg0, 6, b"Ketama", b"Ketama on SUI", b"I am Ketama of the long green candle neck. part Galgo Espanol part giraffe!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mw10_HD_Nn_400x400_8dcc44fa61.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KETAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KETAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

