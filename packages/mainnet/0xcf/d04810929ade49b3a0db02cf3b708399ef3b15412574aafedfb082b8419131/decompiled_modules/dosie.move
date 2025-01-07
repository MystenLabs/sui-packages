module 0xcfd04810929ade49b3a0db02cf3b708399ef3b15412574aafedfb082b8419131::dosie {
    struct DOSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOSIE>(arg0, 6, b"DOSIE", b"Dog side eyed", b"He's judging your double chin...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_225247_7994f71982.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOSIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOSIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

