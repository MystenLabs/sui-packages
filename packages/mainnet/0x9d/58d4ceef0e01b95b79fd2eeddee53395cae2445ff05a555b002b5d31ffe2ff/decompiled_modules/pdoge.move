module 0x9d58d4ceef0e01b95b79fd2eeddee53395cae2445ff05a555b002b5d31ffe2ff::pdoge {
    struct PDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDOGE>(arg0, 6, b"PDOGE", b"PEPE DOGE", b"Tele: https://t.me/pepedoge_channel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/Gw6u6VD.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDOGE>>(v0, @0xc6d1935add6bb05d7e1bce2b8f8b21b332fbdb3007376b1942cc59c2564880a8);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PDOGE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PDOGE>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

