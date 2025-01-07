module 0xb30545920e8be94e9fde4c8040724def42dc59a4b238a102e575d0a2fd530e54::spd {
    struct SPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPD>(arg0, 6, b"SPD", b"suipandog", b"Guess what am I? A dog or a Panda?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/P_tk81_Fs_400x400_3f5f54276d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPD>>(v1);
    }

    // decompiled from Move bytecode v6
}

