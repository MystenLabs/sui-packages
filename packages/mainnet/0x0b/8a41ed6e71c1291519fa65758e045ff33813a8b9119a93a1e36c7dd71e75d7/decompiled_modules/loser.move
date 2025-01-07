module 0xb8a41ed6e71c1291519fa65758e045ff33813a8b9119a93a1e36c7dd71e75d7::loser {
    struct LOSER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOSER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOSER>(arg0, 6, b"LOSER", b"LOSER NEVER B LISTED", x"f09f92805741524e494e473a20446f6ee28099742077617374652074696d65206f72206d6f6e6579206f6e207468697320e2809c67656d2ee2809d204c6f73657220636f6d65732077697468206120e2809c4e65766572204c697374656421e2809d2062616467652e204c696b65206d652c206d616b696e6720666c6f70206d656d65733f2057656c636f6d6520746f20746865206c6f736572732720636c75622e204e6f20736974652c206e6f205477697474657220285829207769746820354d20666f6c6c6f776572732e204869742031304d204d61726b6574204361703f204d61796265207765e280996c6c20676574206120736974652e205343414d20414c455254f09f9aa8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731440721437.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOSER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOSER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

