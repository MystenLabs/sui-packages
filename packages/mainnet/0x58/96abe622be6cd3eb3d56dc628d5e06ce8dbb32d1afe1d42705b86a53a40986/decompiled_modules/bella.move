module 0x5896abe622be6cd3eb3d56dc628d5e06ce8dbb32d1afe1d42705b86a53a40986::bella {
    struct BELLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELLA>(arg0, 6, b"BELLA", b"Bella on Sui", b"$Bella is on a meowssion to reach the moon! Are you coming along for the ride? From a galaxy far away, a brave cat emerges to adventure the universe and learn the secrets of infinite knowledge in legends untold before. The moon is just the beginning of our journey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042437_ba5f6afc4c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

