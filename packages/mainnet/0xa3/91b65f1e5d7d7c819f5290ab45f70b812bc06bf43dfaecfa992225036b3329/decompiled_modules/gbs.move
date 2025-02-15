module 0xa391b65f1e5d7d7c819f5290ab45f70b812bc06bf43dfaecfa992225036b3329::gbs {
    struct GBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBS>(arg0, 6, b"GBS", b"GummyBear On Sui", x"47756d6d79204265617220666972737420617070656172656420696e20616e206164766572746973656d656e7420666f72207468652048617269626f2067756d6d792063616e647920636f6d70616e7920696e20313932322e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_b00ac99335.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

