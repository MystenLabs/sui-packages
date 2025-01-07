module 0x364b1a3d3427590a85e9c7176d1a51c477989762a3643336200a0ea1140b3bd8::FUNNY {
    struct FUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNNY>(arg0, 9, b"FUNNY", b"FUNNY", b"Let's create a FUNNY meme community together on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/hmgrJTq.jpeg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUNNY>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUNNY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNNY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

