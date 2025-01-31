module 0xce36e410e68d252958fdf00914a3ef0add5501fa0f5c856047596caa75d8fdc0::cryptoadz {
    struct CRYPTOADZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTOADZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CRYPTOADZ>(arg0, 6, b"CRYPTOADZ", b"Cryptoadz by SuiAI", b"CrypToadz are a collection 6969 small amphibious creatures trying to escape the tyrannical rule of the Evil King Gremplin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/king_a8154c475f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRYPTOADZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTOADZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

