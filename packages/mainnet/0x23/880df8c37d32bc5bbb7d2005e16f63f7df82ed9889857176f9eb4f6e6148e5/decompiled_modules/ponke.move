module 0x23880df8c37d32bc5bbb7d2005e16f63f7df82ed9889857176f9eb4f6e6148e5::ponke {
    struct PONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKE>(arg0, 9, b"PONKE", b"Ponke On Sui", b"THE GOLDEN CHILD ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=543,h=543,fit=crop/mv0D9x7K43CkLrRP/untitled-1-m2WpMbXEqgiDqPMN.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PONKE>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PONKE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

