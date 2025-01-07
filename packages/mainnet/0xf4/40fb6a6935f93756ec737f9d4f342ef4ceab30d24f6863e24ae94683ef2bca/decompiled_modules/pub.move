module 0xf440fb6a6935f93756ec737f9d4f342ef4ceab30d24f6863e24ae94683ef2bca::pub {
    struct PUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUB>(arg0, 6, b"PUB", b"pure unadulterated bliss", x"0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pub_86b9563471.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

