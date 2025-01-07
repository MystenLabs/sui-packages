module 0x729173958284e4b89af7f382eaaf50cee0355a4c65308d7b23231384b9172ca4::nc {
    struct NC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NC>(arg0, 6, b"NC", b"NeedClaw", b"$NC IS THE STRONGEST MONSTER ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/file_7_O_Ubnfs_Uv199zd_H8q8p1tk_Yo_c7989617d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NC>>(v1);
    }

    // decompiled from Move bytecode v6
}

