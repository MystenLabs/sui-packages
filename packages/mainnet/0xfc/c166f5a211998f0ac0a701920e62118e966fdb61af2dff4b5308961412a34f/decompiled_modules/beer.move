module 0xfcc166f5a211998f0ac0a701920e62118e966fdb61af2dff4b5308961412a34f::beer {
    struct BEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEER>(arg0, 6, b"BEER", b"HODL My Beer", b"\"HOLD My Beer and watch this\" is the line when u know ur bro is gonna do some crazy shit, so u know this coin is gonna do some crazy shit too on this site", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_1_6052bb50d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

