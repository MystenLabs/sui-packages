module 0x6e13b12fed4f311c4d7a5567b321b4a6c4bbd336027d90d4f49cde089af26c93::dogesui {
    struct DOGESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGESUI>(arg0, 9, b"DOGESUI", b"Dogesui", b"Dogesui is the first Meme Coin on Sui Foundation. Telegram : t.me/dogecoinsui , Twitter : https://twitter.com/Dogecoinsui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGESUI>>(v1);
        0x2::coin::mint_and_transfer<DOGESUI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGESUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

