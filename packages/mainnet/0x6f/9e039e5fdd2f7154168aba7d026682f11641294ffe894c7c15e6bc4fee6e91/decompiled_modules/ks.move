module 0x6f9e039e5fdd2f7154168aba7d026682f11641294ffe894c7c15e6bc4fee6e91::ks {
    struct KS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KS>(arg0, 6, b"KS", b"COUNTE STOIKE", b"COUNTE STOIKE 2.0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Counter_Strike_2_1_d7381d7d52.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KS>>(v1);
    }

    // decompiled from Move bytecode v6
}

