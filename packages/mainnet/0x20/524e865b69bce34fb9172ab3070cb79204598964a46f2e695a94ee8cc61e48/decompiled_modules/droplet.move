module 0x20524e865b69bce34fb9172ab3070cb79204598964a46f2e695a94ee8cc61e48::droplet {
    struct DROPLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROPLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPLET>(arg0, 9, b"DROPLET", b"Droplet", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/LNFYex4.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DROPLET>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DROPLET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPLET>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

