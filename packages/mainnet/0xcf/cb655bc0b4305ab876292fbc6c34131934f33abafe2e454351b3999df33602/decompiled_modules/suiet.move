module 0xcfcb655bc0b4305ab876292fbc6c34131934f33abafe2e454351b3999df33602::suiet {
    struct SUIET has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIET>, arg1: 0x2::coin::Coin<SUIET>) {
        0x2::coin::burn<SUIET>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<SUIET>, arg1: &mut 0x2::coin::Coin<SUIET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<SUIET>(arg0, 0x2::coin::split<SUIET>(arg1, arg2, arg3));
    }

    fun init(arg0: SUIET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIET>(arg0, 6, b"SUIET", b"SUIET", b"Man SUIET Fan Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1563421779061706752/fxx-7Qny_400x400.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIET>(&mut v2, 500000000000000000, @0xffed1e3a3b44c55d8a1300bf9ad7abb11825d45e66ab4bcadb5f7b5f4bce7d3a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIET>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

