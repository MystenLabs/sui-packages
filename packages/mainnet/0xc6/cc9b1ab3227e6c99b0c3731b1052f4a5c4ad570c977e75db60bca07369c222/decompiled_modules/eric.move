module 0xc6cc9b1ab3227e6c99b0c3731b1052f4a5c4ad570c977e75db60bca07369c222::eric {
    struct ERIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERIC>(arg0, 6, b"ERIC", b"Eric on Sui", x"4d6565742024455249432e2020456c6f6e204d75736b27732070657420676f6c64666973682020746865206669727374204f472066697368206f6e207468652053756920626c6f636b636861696e21200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_550c58da15.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

