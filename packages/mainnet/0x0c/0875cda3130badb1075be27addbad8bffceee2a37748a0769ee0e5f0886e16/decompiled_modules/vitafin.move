module 0xc0875cda3130badb1075be27addbad8bffceee2a37748a0769ee0e5f0886e16::vitafin {
    struct VITAFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VITAFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VITAFIN>(arg0, 6, b"Vitafin", b"LLJEFFY", x"57656273697465203a2068747470733a2f2f6d6972726f722e78797a2f6a79752e6574680a446f63756d656e74203a2068747470733a2f2f6d6972726f722e78797a2f6a79752e6574682f456b6435526a564768796751554855534543736c4f717a78736f4e463965414b6a714777513250436f4a550a4f626974203a2068747470733a2f2f7777772e6c65676163792e636f6d2f75732f6f6269747561726965732f7366676174652f6e616d652f6a656666792d79752d6f626974756172793f7069643d323039303434363233", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaro2gu5kmmljxxypvgd3e6de2sy3f6hlidqlvzqhumocqo4b7qmu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VITAFIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VITAFIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

