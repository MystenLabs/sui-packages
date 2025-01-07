module 0xb5350779cd17d80a0e0931edecc473caa31f98e6d86fee9603c2044fc15a1e40::dogesui {
    struct DOGESUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGESUI>, arg1: 0x2::coin::Coin<DOGESUI>) {
        0x2::coin::burn<DOGESUI>(arg0, arg1);
    }

    fun init(arg0: DOGESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGESUI>(arg0, 9, b"DOGESUI", b"Dogesui", b"The first Meme Coin on Sui Blockchain. Telegram : t.me/Dogecoinsui , Twitter : https://twitter.com/dogecoinsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gateway.pinata.cloud/ipfs/Qmb1LzShPagMPB9GWrwMEms9fPgbuTBhZ6cpSBXCgYRqtb?_gl=1*n4z9rt*rs_ga*ODJhNjIwYmEtMWRiOC00MTRlLWIwMDctOTI1NDY2ODFjZGQ2*rs_ga_5RMPXG14TE*MTY4MzIyMzU2My4zLjEuMTY4MzIyMzU2Ni41Ny4wLjA."))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGESUI>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<DOGESUI>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGESUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGESUI>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

