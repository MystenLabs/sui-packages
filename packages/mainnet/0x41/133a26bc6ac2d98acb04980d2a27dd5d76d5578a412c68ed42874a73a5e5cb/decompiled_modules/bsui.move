module 0x41133a26bc6ac2d98acb04980d2a27dd5d76d5578a412c68ed42874a73a5e5cb::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUI>(arg0, 9, b"BSUI", b"BabySui", b"BabySui Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/Mv1hlkx.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUI>>(v0, @0xad802d3eccbb27486227c4f4215be55ca53b1daec8ba970b59d24e7a91fc7841);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BSUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BSUI>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

