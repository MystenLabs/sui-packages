module 0x30b15a009b6d8cc6ba8b7ad8afd7754862423ceb86b4f0bc424597e644b0c55b::ruby {
    struct RUBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUBY>(arg0, 6, b"RUBY", b"Sui Ruby", b"Ruby - The most memeable memecoin to go beyond infinity ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006995_8101b86061.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

