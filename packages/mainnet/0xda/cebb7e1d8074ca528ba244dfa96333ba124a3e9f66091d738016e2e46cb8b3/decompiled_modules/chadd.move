module 0xdacebb7e1d8074ca528ba244dfa96333ba124a3e9f66091d738016e2e46cb8b3::chadd {
    struct CHADD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHADD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHADD>(arg0, 9, b"CHADD", b"SuiChad", b"SuiChad to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1828137222903828480/2bKWSRMo.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHADD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHADD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHADD>>(v1);
    }

    // decompiled from Move bytecode v6
}

