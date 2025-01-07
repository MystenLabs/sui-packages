module 0x3f001013b75ce01da877ae7ab0fe875259706be59a73c731cb95db09a579d772::luigibook {
    struct LUIGIBOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUIGIBOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUIGIBOOK>(arg0, 6, b"LUIGIBOOK", b"BOOK OF LUIGI", x"4c756967692074616b65732063656e7465722073746167652c20626f6c642c0a646172696e672c20616e642061726d6564207769746820610a6d697373696f6e20746f207368616b65207570207468650a73797374656d2e2046726f6d20686561646c696e657320746f207468650a73706f746c696768742c20244c55494749424f4f4b20697320666f720a74686f73652077686f206465667920746865206f64647320616e640a72657772697465207468652067616d652e204e6f20736861646f77732c0a6e6f207365636f6e6420706c6163652c206a75737420706f7765722c0a677269742c20616e6420666561726c65737320616d626974696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul13_20241216113423_7d95f7dc2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUIGIBOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUIGIBOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

