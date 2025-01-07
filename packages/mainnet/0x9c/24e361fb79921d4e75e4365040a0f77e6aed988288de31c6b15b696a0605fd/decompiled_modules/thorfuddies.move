module 0x9c24e361fb79921d4e75e4365040a0f77e6aed988288de31c6b15b696a0605fd::thorfuddies {
    struct THORFUDDIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: THORFUDDIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THORFUDDIES>(arg0, 6, b"ThorFuddies", b"Thor Fuddies", b"Thor Fuddies is Fuddies Thor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_28_T230926_999_bec5fb906f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THORFUDDIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THORFUDDIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

