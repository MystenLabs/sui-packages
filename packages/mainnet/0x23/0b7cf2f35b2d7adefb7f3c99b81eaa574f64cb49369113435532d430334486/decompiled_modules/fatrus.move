module 0x230b7cf2f35b2d7adefb7f3c99b81eaa574f64cb49369113435532d430334486::fatrus {
    struct FATRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATRUS>(arg0, 6, b"FATRUS", b"WalrusFatCoin", b"Don't think too much, enjoy life, smoke your cigarettes, that's a tip from $FATRUS so you can get fat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250508_184736_600fb51cb5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATRUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATRUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

