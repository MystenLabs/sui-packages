module 0xdf7b8ef4b941a57e90bc6a794b9735936ef041491e65493e468c7babfdead00b::empawroar {
    struct EMPAWROAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMPAWROAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMPAWROAR>(arg0, 6, b"EMPAWROAR", b"KaboSui The Emperor", x"546865206d6f737420706f77657266756c20656d706177726f617220746f20657665722073657420666f6f7420696e20537569210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6089260686896120355_1_0d2aa1d7e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMPAWROAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMPAWROAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

