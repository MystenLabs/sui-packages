module 0x8bf9bfead83a8f575a16016ae02c66eee73338dd4169f04bb7e7624d6fb54204::sheesh {
    struct SHEESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEESH>(arg0, 6, b"SHEESH", b"SHEESH SUI", b"Sheesh! Chill out bro. Yea, you've found a gem. Yea, you'll have enough money for that lambo you always dreamt of. Yes, yes, you can feed your village. Sheesh. Just join us already...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sheesh4_copy_b81494d60b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEESH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEESH>>(v1);
    }

    // decompiled from Move bytecode v6
}

