module 0x413e4e886aa1ea3b363cc0653a9b65e04b18a7d93b59fecfb8ef3d4425aa1f7a::ppk {
    struct PPK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPK>(arg0, 6, b"PPK", b"PewPewKittens", b"PewPewKittens On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_05_07_28_29_62861ce841.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPK>>(v1);
    }

    // decompiled from Move bytecode v6
}

