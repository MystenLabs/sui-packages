module 0x16e6c5e4fb7679bbc1e589c1fd6e3da9df315f7273be6c5b47c206109de48d9c::dook {
    struct DOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOK>(arg0, 6, b"DOOK", b"First Shoobadookie On Sui", b"Dexscreener Paid.Join now : https://shoobadookiesui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_1_72bca59ae4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

