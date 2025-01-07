module 0xad215644bea9b6d7f464fb9d263a65a03d41332e172737ae555e9d2e30052fff::koisui {
    struct KOISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOISUI>(arg0, 6, b"KoiSui", b"Koisui", b"KoiSui is a meme token that swims to success like a koi fish but against the current... You may not become a millionaire, but at least you can fish on the blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logos_0a9033530e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

