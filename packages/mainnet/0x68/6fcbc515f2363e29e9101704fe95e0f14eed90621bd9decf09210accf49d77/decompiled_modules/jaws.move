module 0x686fcbc515f2363e29e9101704fe95e0f14eed90621bd9decf09210accf49d77::jaws {
    struct JAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAWS>(arg0, 6, b"JAWS", b"Jaws - The Famous Shark on SUI", x"427261636520796f757273656c662c20746865206b696e67206f66207468652064656570206973204241434b210a0a52656d656d6265722074686520736861726b2074686174206d61646520796f75206a756d703f2057656c6c2c20244a41575320686173207375726661636564206f6e205355492c20616e642069747320726561647920746f206665617374210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_21_52_36_0ed638ced3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

