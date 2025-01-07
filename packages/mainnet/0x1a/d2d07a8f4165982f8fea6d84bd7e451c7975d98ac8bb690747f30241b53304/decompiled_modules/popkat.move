module 0x1ad2d07a8f4165982f8fea6d84bd7e451c7975d98ac8bb690747f30241b53304::popkat {
    struct POPKAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPKAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPKAT>(arg0, 6, b"POPKAT", b"Popkat", b"The kat that Pops, multichain meme maskot on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002456_e8a81f45b2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPKAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPKAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

