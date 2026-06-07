module 0x6dad80e630afa70a7bbb169752e661e5f5b383558259e134305f52c1a748a85b::dilithion {
    struct DILITHION has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DILITHION>, arg1: 0x2::coin::Coin<DILITHION>) {
        0x2::coin::burn<DILITHION>(arg0, arg1);
    }

    fun init(arg0: DILITHION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DILITHION>(arg0, 9, 0x1::string::utf8(b"wDIL"), 0x1::string::utf8(b"Dilithion"), 0x1::string::utf8(x"44696c697468696f6e2069732061204c6179657220312063727970746f63757272656e637920746861742075736573204352595354414c532d44696c69746869756d20284d4c2d4453412d36352c2046495053203230342920e2809420746865204e4953542d7374616e64617264697a656420706f73742d7175616e74756d206469676974616c207369676e617475726520616c676f726974686d20e28094206f6e206576657279207472616e73616374696f6e2066726f6d20626c6f636b207a65726f2e204f6666696369616c20776562736974653a2068747470733a2f2f64696c697468696f6e2e6f7267"), 0x1::string::utf8(b"https://cdn.discordapp.com/icons/1434127139057172560/a10be04ec0f68f666fac3422b8e09fe7.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DILITHION>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DILITHION>>(0x2::coin_registry::finalize<DILITHION>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DILITHION>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DILITHION>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

