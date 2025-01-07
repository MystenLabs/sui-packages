module 0xa7f0c84e69408bc722e786320a1d0c19e982a63c956d785a54f86206754105a3::bluppy {
    struct BLUPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUPPY>(arg0, 6, b"BLUPPY", b"Bluppy", b"Bluppy, the cheerful blue mascot, is always ready to bring waves of joy and fun to every beach day!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tokenn_3c8607bdc8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

