module 0xbbbca572c1ece6e410bed2bfaea290272db3ff4af8d79a7d1c77025463dd0039::jfc {
    struct JFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JFC>(arg0, 6, b"JFC", b"Jackie Fine Chicken", b"This Colonel doesnt just lift buckets, he lifts the whole restaurant!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250116_153145_1e055fd533.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

