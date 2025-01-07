module 0xf3bc0ec2e7880eca357c89d3b019714b8b35e63e5d5ad1733796470b9a177f69::czhao {
    struct CZHAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZHAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZHAO>(arg0, 6, b"Czhao", b"Changpeng Zhao", b"cz's four fingers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a2a9fb25_a206_44f2_8e8c_3eb69ca2796c8379160348531197995_ee9f227b19.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZHAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZHAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

