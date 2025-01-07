module 0xd9bca8e8a850a808e09fcf38bfcda2d78f5666181af659975619049392b05bb8::babywhale {
    struct BABYWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYWHALE>(arg0, 6, b"BABYWHALE", b"Baby Whale", b"Just a baby whale on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_Afdemk_Wu_Pt_Ogf_Sr_7b67555110.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

