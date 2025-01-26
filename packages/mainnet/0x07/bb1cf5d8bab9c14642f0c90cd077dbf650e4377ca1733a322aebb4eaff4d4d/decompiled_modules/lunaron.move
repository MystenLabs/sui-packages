module 0x7bb1cf5d8bab9c14642f0c90cd077dbf650e4377ca1733a322aebb4eaff4d4d::lunaron {
    struct LUNARON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNARON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LUNARON>(arg0, 6, b"LUNARON", b"LUNARON by SuiAI", b"Lunaron is not just a token. It's an AI creating a new space for NFTs, gaming, and a vibrant community to grow. Come be a part of the adventure!.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/lunr_5e1688d0f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUNARON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNARON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

