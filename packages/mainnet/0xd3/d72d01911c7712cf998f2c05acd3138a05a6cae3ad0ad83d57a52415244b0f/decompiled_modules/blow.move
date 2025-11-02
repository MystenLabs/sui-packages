module 0xd3d72d01911c7712cf998f2c05acd3138a05a6cae3ad0ad83d57a52415244b0f::blow {
    struct BLOW has drop {
        dummy_field: bool,
    }

    public entry fun change_icon_url(arg0: &mut 0x2::coin_registry::Currency<BLOW>, arg1: &0x2::coin_registry::MetadataCap<BLOW>, arg2: 0x1::string::String) {
        0x2::coin_registry::set_icon_url<BLOW>(arg0, arg1, arg2);
    }

    fun init(arg0: BLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BLOW>(arg0, 9, 0x1::string::utf8(b"MYFC"), 0x1::string::utf8(b"My Fixed Coin"), 0x1::string::utf8(b"An unregulated fixed-supply coin on Sui with 10B total."), 0x1::string::utf8(b"https://static.vecteezy.com/system/resources/thumbnails/050/465/542/small/weird-face-cat-meme-sticker-cute-illustration-vector.jpg"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin::mint_and_transfer<BLOW>(&mut v2, 10000000000000000000, @0xef72cb4baaf878f0db211273d230842db87c36ecf1f9493a77a9c5af1c596df5, arg1);
        0x2::coin_registry::make_supply_fixed_init<BLOW>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BLOW>>(0x2::coin_registry::finalize<BLOW>(v3, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

