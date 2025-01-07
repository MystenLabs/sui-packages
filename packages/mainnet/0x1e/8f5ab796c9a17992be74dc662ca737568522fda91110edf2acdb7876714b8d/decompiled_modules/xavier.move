module 0x1e8f5ab796c9a17992be74dc662ca737568522fda91110edf2acdb7876714b8d::xavier {
    struct XAVIER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<XAVIER>, arg1: 0x2::coin::Coin<XAVIER>) {
        0x2::coin::burn<XAVIER>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<XAVIER>, arg1: &mut 0x2::coin::Coin<XAVIER>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<XAVIER>(arg0, 0x2::coin::split<XAVIER>(arg1, arg2, arg3));
    }

    fun init(arg0: XAVIER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAVIER>(arg0, 6, b"XAVIER", b"XAVIER", b"XAVIERad Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://varnam.my/wp-content/uploads/2021/01/FB_IMG_1605666747087-2.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XAVIER>(&mut v2, 314000000000000000, @0xffed1e3a3b44c55d8a1300bf9ad7abb11825d45e66ab4bcadb5f7b5f4bce7d3a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XAVIER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAVIER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

