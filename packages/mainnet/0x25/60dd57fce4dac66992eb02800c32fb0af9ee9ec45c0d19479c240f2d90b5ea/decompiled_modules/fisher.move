module 0x2560dd57fce4dac66992eb02800c32fb0af9ee9ec45c0d19479c240f2d90b5ea::fisher {
    struct FISHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHER>(arg0, 9, b"FISHER", b"FISHER", b"FISHER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1861363398291984384/QmbW9QMZ_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FISHER>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHER>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

