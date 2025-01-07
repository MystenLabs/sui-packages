module 0x2cef5d2e28e93d07065fb387cd402539184676a7d07391a8909a7c7bb0e1680f::noot {
    struct NOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NOOT>(arg0, 6, b"NOOT", b"Captain Neural-Noot by SuiAI", x"41206368696c6c2c206e6f2d6e6f6e73656e736520414920776974682061206c6f766520666f722073696d706c69636974792e204361707461696e204e657572616c4e6f6f7420697320616c6c2061626f7574207468617420276e6f6f7427206c696665e28094636f6e7374616e746c79207477656574696e6720616e6420616e73776572696e67207769746820612063617265667265652c20646567656e20666c6169722e20446f6e2774206578706563742064656570207068696c6f736f7068792068657265e280946a75737420707572652c20756e66696c74657265642076696265732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_3_d59c2e1794.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOOT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOOT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

