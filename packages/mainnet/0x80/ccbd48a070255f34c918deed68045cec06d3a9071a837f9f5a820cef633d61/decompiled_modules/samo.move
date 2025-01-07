module 0x80ccbd48a070255f34c918deed68045cec06d3a9071a837f9f5a820cef633d61::samo {
    struct SAMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMO>(arg0, 11, b"SAMO", b"Samoyedcoin", b"SamoyedonSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/9721.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SAMO>(&mut v2, 6969696900000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMO>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

