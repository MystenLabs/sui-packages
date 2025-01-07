module 0x5f02cbe50869529ef3ba34cd7a5cd45f1ad8d3b930e1c3e3d4dd0ddd9b62c9f7::waat {
    struct WAAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAAT>(arg0, 6, b"WAAT", b"Water at 3AM", b"Discover why water tastes so good at 3am with hilarious memes and explanations", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_28_12_35_18_648d3efbc9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

