module 0x9e6cba0c3ec0945cbf0114d2a9c3de67bc980f6a2236ae09e86c762f1d7f5a84::suifuu {
    struct SUIFUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFUU>(arg0, 6, b"SUIFUU", b"SUIFU", b"In a vibrant digital landscape where the realms of crypto and culture collide, Sui Fu emerges as a unique memecoin project, bringing to life the legendary story of a kung fu turtle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_18_23_09_7fb9b3e0a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

