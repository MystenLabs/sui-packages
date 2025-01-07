module 0x56d5882956af492bc3f69131f8cdcb78400236104f7b69e32eadadca95df9163::monkeysi {
    struct MONKEYSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEYSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEYSI>(arg0, 6, b"MonkeySi", b"Monkey Sida", b"Monkey meme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f55b1e48_ac29_4db3_b405_92910232af4b_266c0c51c7.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEYSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKEYSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

