module 0x28d4c483b7485085a723ddb56d62eef1ea28d07bcdd02b37b3ae8961c18f2206::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"&TRUMP", x"4e6f20547769747465722c206e6f2054656c656772616d2c206e6f20776562736974652c206e6f7468696e672e0a486f74205472756d702063616d6520746f206265617420636f6c64205355492e0a0a492077696c6c2070726f64756365207468697320636f696e20616e64206d656574206d792064656174682e0a0a4a757374206c696b65205361746f736869206469642e2e2e0a0a4c6f6e67206c69766520507265736964656e74205472756d702e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_President_Trump_standing_behind_a_vibrant_int_2_ea5007fa8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

