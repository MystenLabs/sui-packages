module 0xa9500d4f2268fb31cedff627abce1506df736a3c62dff85b69618897072688a6::lnc {
    struct LNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LNC>(arg0, 9, b"LNC", b"LionCat v2 (complete Migration: lncv2.co)", b"Lnc is goin on", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/200x200/29296.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LNC>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LNC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

