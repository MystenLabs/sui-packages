module 0xb8095c5fa32ee8946f6683ee94ea28d2816a2d211a582949ca6066a9a7b0ef2b::muds {
    struct MUDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUDS>(arg0, 6, b"MUDS", b"SUI Mudkips", b"\"I Herd U Liek Mudkips\" A legendary memecoin born from the ancient halls of /b/. Straight outta 2007 internet culture chaotic, nostalgic, and proudly useless. Powered by SUI, made for the true degens who remember when memes were sacred. No utility, no roadmap. Just Mudkips.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_05_09_02_05_50_d62e7cb7aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

