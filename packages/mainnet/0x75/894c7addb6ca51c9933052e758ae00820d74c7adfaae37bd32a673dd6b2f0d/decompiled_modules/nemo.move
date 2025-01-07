module 0x75894c7addb6ca51c9933052e758ae00820d74c7adfaae37bd32a673dd6b2f0d::nemo {
    struct NEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMO>(arg0, 6, b"NEMO", b"SuiNemoFish", b"NEMO is a meme token inspired by the playful spirit of NEMO, with a fresh underwater twist. NEMO aims to become the leading meme token of the SUI ecosystem, swimming through the waves of crypto with humor and creativity. While its just a fun token with no guaranteed value, its limitless potential comes from the freedom to create, laugh, and ride the currents of the meme-iverse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fish_is_the_ticker_f2ac44f569.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

