module 0xfc37efebb3ed232ff1c0e0130f4809a48d924bc31c2195ddfa051f3784dffdfc::khai {
    struct KHAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHAI>(arg0, 6, b"KHAI", b"KittenHaimer", x"4d79206475747920697320536166656775617264696e67207468652063617420636f6d6d756e6974790a2620656d626f6479696e672074686520737069726974206f6620766967696c616e636520696e20657665727920656e646561766f722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/khaizer_a514bee47d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KHAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

