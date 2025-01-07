module 0x4334246973752e116cac19030873cd1cc21f7d5b032454b4061ccc661248b7f2::unisui {
    struct UNISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNISUI>(arg0, 6, b"UNISUI", b"Sui Unicorn", b"UNISUI - the game-changing horse galloping on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051826_948b6e37b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

