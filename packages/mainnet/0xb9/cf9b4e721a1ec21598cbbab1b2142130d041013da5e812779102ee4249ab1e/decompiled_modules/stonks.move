module 0xb9cf9b4e721a1ec21598cbbab1b2142130d041013da5e812779102ee4249ab1e::stonks {
    struct STONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONKS>(arg0, 9, b"STONKS", b"suistonks", b"Wet Stonks, Higher Returns!  https://t.me/suistonks  https://x.com/suistonksonsui  https://www.suistonks.fun/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1729084663066-b2f98b1932b16681fcd4c348819b90aa.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STONKS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONKS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

