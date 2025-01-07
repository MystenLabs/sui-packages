module 0x17e8ce29a7fc24c78c82e1c66a8980ed0c96e4d90f458b26f10b98f811dd7081::duko {
    struct DUKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKO>(arg0, 9, b"Duko", b"SuiDuko", b"$SuiDuko is the cutest Sui Pet Aimed to bring all the dog lovers to a low fees chain that empoweres memes and communities  Website: https://suiduko.website/ Twitter: https://x.com/SuiDuko Telegram: https://t.me/SuiDuko", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1728461168885-38d1b3abc28a31879f1a5151572218fd.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUKO>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

