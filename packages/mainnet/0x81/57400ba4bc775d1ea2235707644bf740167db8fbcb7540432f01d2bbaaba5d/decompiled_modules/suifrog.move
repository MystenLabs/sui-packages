module 0x8157400ba4bc775d1ea2235707644bf740167db8fbcb7540432f01d2bbaaba5d::suifrog {
    struct SUIFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFROG>(arg0, 6, b"SuiFrog", b"SuiFrogs", b"SuiFrogs is a fun and playful meme token represented by a mischievous green frog mascot wearing a crown, symbolizing its reign in the meme token world. With a lighthearted and vibrant design, SuiFrogs captures the energy of both nature and the digital realm, making it a standout token in the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000355_69594fbf8d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

