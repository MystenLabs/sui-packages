module 0x454bb8330b4a07c008f492d7527c3f60067d4f674b065fa18dd32a0720b72e3b::mdng {
    struct MDNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDNG>(arg0, 6, b"MDNG", b"Moo Deng on Sui", b"Moo Deng SUI MEME  About moo deng is just a viral lil hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/moodeng_ab612139a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

