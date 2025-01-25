module 0x9361b03d6e2425413b26f0d199459539f8f4da2f1ec71fbe199d283d533852ab::karak {
    struct KARAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KARAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KARAK>(arg0, 6, b"Karak", b"Karak Enjoyooor", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i7e7al_Pd_400x400_795ae2b9c2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KARAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KARAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

