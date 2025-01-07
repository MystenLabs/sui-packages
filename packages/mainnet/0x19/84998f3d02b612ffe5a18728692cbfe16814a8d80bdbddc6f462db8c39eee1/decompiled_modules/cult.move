module 0x1984998f3d02b612ffe5a18728692cbfe16814a8d80bdbddc6f462db8c39eee1::cult {
    struct CULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULT>(arg0, 6, b"CULT", b"MILADY CULT", b"Trillion dollar infrared propaganda booklet happiness fiber optic prison cube mindset conversion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_2_5bc79d8dd2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CULT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CULT>>(v1);
    }

    // decompiled from Move bytecode v6
}

