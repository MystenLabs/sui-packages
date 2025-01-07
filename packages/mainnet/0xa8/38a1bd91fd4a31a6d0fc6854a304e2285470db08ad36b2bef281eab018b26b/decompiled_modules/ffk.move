module 0xa838a1bd91fd4a31a6d0fc6854a304e2285470db08ad36b2bef281eab018b26b::ffk {
    struct FFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFK>(arg0, 6, b"FFK", b"FIREFLY KING", b"Lighting up dark wallets and leading the way to profits. Bow down to the king of memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_032210843_99fb187eaa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFK>>(v1);
    }

    // decompiled from Move bytecode v6
}

