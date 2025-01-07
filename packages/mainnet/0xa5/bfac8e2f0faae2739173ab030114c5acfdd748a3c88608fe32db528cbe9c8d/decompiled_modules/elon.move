module 0xa5bfac8e2f0faae2739173ab030114c5acfdd748a3c88608fe32db528cbe9c8d::elon {
    struct ELON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ELON>, arg1: 0x2::coin::Coin<ELON>) {
        0x2::coin::burn<ELON>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<ELON>, arg1: &mut 0x2::coin::Coin<ELON>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<ELON>(arg0, 0x2::coin::split<ELON>(arg1, arg2, arg3));
    }

    fun init(arg0: ELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELON>(arg0, 6, b"ELON", b"ELON", b"ELON Meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cdn.vox-cdn.com/thumbor/WYZNb2sx7XuDb9ALk49LQtjF_IQ=/0x0:4000x2781/1400x1400/filters:focal(2000x1391:2001x1392)/cdn.vox-cdn.com/uploads/chorus_asset/file/22520460/1229901686.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELON>(&mut v2, 314000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

