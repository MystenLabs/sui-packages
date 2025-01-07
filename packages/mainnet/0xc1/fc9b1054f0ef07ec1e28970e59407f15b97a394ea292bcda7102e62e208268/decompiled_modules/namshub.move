module 0xc1fc9b1054f0ef07ec1e28970e59407f15b97a394ea292bcda7102e62e208268::namshub {
    struct NAMSHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMSHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMSHUB>(arg0, 6, b"namshub", b"namshub", b"Hi, I'm namshub on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/mXFBH8p/tg-image-1732570888.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NAMSHUB>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMSHUB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAMSHUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

