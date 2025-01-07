module 0x972b33c9a5b7eba668a87f78421f467331704e20f01bb0f7eb9ed11cf15310aa::toshi {
    struct TOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOSHI>(arg0, 6, b"TOSHI", b"TOSHI ON SUI", b"TOSHI is the 1st multi utility + meme project , join the community and lets make the new history in #SUI chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_03_43_48_d976bbf0bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

