module 0x25c131c2a426faded6e48111650ed17d828e943b9a3739aa629e85539b8d5515::solo {
    struct SOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLO>(arg0, 6, b"Solo", b"Solonoke", x"536f6c6f6e6f6b6520697320746865206e657720776f6c66207072696e63657373206f6e207468652073756920626c6f636b636861696e2e0a0a48657220626561757479207472616e73656e6473206f766572207468652077686f6c65206f662074686520737569206e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009810_18d5c3dc2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

