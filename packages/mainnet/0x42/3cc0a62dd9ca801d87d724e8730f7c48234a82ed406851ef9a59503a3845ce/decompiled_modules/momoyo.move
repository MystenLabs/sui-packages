module 0x423cc0a62dd9ca801d87d724e8730f7c48234a82ed406851ef9a59503a3845ce::momoyo {
    struct MOMOYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMOYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMOYO>(arg0, 6, b"MOMOYO", b"Momoyo On Sui", b"Momoyo the 1st Ice Cream Memecoin on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017617_71ce815756.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMOYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOMOYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

