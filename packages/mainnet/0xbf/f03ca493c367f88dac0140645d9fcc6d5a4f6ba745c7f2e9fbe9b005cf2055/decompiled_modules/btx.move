module 0xbff03ca493c367f88dac0140645d9fcc6d5a4f6ba745c7f2e9fbe9b005cf2055::btx {
    struct BTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTX, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<BTX>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<BTX>(arg0, b"BTX", b"BEETHOVEN", b"LUDWIG VAN BEETHOVEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/a81bd859-a1f6-49ef-9a72-975b18ddfd64")), b"https://www.powercoin.it/ru/okeaniya/5315-ludwig-van-beethoven-famous-artists-zoloto-moneta-25-niue-2020.html", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00739c69684cf992651ce411ea9f140eda46c7ed519093e5b743b5e46be16410b25851c32d6eb3961024081fc4c10a114a7324420f55f4c883d664a2df48d1f405f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737109582"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

