module 0x5bcc86b333d39d718413afe68af28e6c7f50ae4fe5d395dcab2efc52cfd66a4::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TRUMP>, arg1: 0x2::coin::Coin<TRUMP>) {
        0x2::coin::burn<TRUMP>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<TRUMP>, arg1: &mut 0x2::coin::Coin<TRUMP>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<TRUMP>(arg0, 0x2::coin::split<TRUMP>(arg1, arg2, arg3));
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"TRUMP", b"TRUMP Meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://static.independent.co.uk/s3fs-public/thumbnails/image/2016/09/13/11/trumpmeme.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMP>(&mut v2, 314000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

