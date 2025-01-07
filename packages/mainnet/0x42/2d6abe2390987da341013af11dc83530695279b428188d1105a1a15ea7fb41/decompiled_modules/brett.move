module 0x422d6abe2390987da341013af11dc83530695279b428188d1105a1a15ea7fb41::brett {
    struct BRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETT>(arg0, 9, b"BRETT", b"Brett", b"Brett is everywhere and now also on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F1000030135_c5a2291a23.jpg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BRETT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETT>>(v2, @0x3e5a78284e4680cb2230cc8de33b29ce19b79ec47c36cf28c8b1b2e3ec44e178);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

