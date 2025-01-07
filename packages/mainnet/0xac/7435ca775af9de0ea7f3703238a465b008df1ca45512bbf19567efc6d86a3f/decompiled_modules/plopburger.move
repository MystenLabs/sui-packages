module 0xac7435ca775af9de0ea7f3703238a465b008df1ca45512bbf19567efc6d86a3f::plopburger {
    struct PLOPBURGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOPBURGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOPBURGER>(arg0, 6, b"PlopBurger", b"Plop Burger", b"Inspired by a viral moment of Trump saying \"crypto burger,\" this token is cooking up something big in the sui space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tumblr_3dfdc0d186976cc691d92120a6575e7f_8b36c24e_400_24c01bcbf8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOPBURGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOPBURGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

