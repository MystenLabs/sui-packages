module 0xd822594bcfe061e0c2274098ab630d9c9674425a846ad0026380ebd46ea0bf5f::rare {
    struct RARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RARE>(arg0, 6, b"RARE", b"Lober", b"Hi, Im Lober a rare blue lobster in Sui sea. Finding me is like finding a Charizard Pokemon card. I could be worth 100k. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lober_2641c8fcec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RARE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RARE>>(v1);
    }

    // decompiled from Move bytecode v6
}

