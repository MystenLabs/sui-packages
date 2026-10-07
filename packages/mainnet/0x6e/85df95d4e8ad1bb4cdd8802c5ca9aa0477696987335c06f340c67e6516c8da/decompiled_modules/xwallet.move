module 0x6e85df95d4e8ad1bb4cdd8802c5ca9aa0477696987335c06f340c67e6516c8da::xwallet {
    struct XWALLET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<XWALLET>, arg1: 0x2::coin::Coin<XWALLET>) {
        0x2::coin::burn<XWALLET>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<XWALLET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XWALLET>>(0x2::coin::mint<XWALLET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: XWALLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XWALLET>(arg0, 9, b"XWALLET", b"XWALLET", b"XWALLET(TM) Copyrights and trademarks all property of their respective owners. All rights reserved", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreigifsjbbo5askkjozynptaldzmhvkvhfxodu42xrmapsvgrgqy6wm")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<XWALLET>>(0x2::coin::mint<XWALLET>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XWALLET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XWALLET>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

