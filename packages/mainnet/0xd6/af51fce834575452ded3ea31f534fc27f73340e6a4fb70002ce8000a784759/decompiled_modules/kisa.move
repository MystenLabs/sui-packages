module 0xd6af51fce834575452ded3ea31f534fc27f73340e6a4fb70002ce8000a784759::kisa {
    struct KISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KISA>(arg0, 6, b"kisa", b"kisa", b"meow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/RTdgG7B/pfp.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KISA>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KISA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KISA>>(v1);
    }

    // decompiled from Move bytecode v6
}

