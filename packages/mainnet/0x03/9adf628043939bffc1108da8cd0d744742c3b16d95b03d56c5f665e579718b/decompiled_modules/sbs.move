module 0x39adf628043939bffc1108da8cd0d744742c3b16d95b03d56c5f665e579718b::sbs {
    struct SBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBS>(arg0, 9, b"SBS", x"53757065722042756c6c2053756e64617920f09f9082f09f9388", b" Super Bull Sunday (SBS)  The ultimate crypto play for a roaring bull market! No penalties, no timeoutsjust non-stop gains. Are you ready for the biggest run of the season? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/n5qcOdaptLvsffNC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SBS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

