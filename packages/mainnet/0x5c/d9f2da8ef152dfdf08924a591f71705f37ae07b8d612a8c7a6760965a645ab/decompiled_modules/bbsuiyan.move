module 0x5cd9f2da8ef152dfdf08924a591f71705f37ae07b8d612a8c7a6760965a645ab::bbsuiyan {
    struct BBSUIYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBSUIYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBSUIYAN>(arg0, 6, b"BBSUIYAN", b"Baby Suiyan", b"Baby SuiYan is the adorable, youthful form of SuiYan, brimming with pure energy and limitless potential. Despite his small size, he shows an innate talent for controlling elemental forces, always holding a glowing droplet of water in his tiny hand.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiyan_6ece23956c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBSUIYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBSUIYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

