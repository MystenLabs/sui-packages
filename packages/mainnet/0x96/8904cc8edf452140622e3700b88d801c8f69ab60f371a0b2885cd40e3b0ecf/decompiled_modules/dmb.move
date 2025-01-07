module 0x968904cc8edf452140622e3700b88d801c8f69ab60f371a0b2885cd40e3b0ecf::dmb {
    struct DMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMB>(arg0, 6, b"DMB", b"DUMBO", b"Moon this one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000199153_b573b71b93.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

