module 0x45815bf8926999e83c6c773a5e3c6e92afd3b54b76f14523baa853a20db533e0::nogas {
    struct NOGAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOGAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOGAS>(arg0, 9, b"NOGAS", b"Nogas", b"Built Thin. Moves Star", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2111914461720178688/B0z5W0tV.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOGAS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOGAS>>(v2, @0xa89b982af94caa6d8cff861407e5c30e1d81217b16f66a3853f885e55882d97e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOGAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

