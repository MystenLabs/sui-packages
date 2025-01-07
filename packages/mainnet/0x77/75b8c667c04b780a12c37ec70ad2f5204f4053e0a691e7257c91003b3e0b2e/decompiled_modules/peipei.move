module 0x7775b8c667c04b780a12c37ec70ad2f5204f4053e0a691e7257c91003b3e0b2e::peipei {
    struct PEIPEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEIPEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEIPEI>(arg0, 6, b"PEIPEI", b"PeiPei on Sui", x"546865203173742024506569506569206465706c6f796564206f6e205375692c20636f6d6d756e6974792d6d616e616765642e0a5468652068656972206170706172656e74202e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_O_O_U_U_O_U_12_539184ed99.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEIPEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEIPEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

