module 0x39fdd7d8543ede235d54946eeee2bed7bae1d9245c9d05535ddcd3ea10e3da1b::babysui {
    struct BABYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSUI>(arg0, 6, b"BaBySUI", b"BaBySUI", b"BaBySUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmQM7BvirLLfTyt1sjbFzw1z1UZ1ejvGS71NYGYepnqLs1"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYSUI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYSUI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BABYSUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

