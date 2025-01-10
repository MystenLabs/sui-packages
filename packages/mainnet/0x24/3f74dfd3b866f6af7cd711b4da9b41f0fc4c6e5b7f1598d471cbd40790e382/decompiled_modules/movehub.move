module 0x243f74dfd3b866f6af7cd711b4da9b41f0fc4c6e5b7f1598d471cbd40790e382::movehub {
    struct MOVEHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEHUB>(arg0, 6, b"MOVEHUB", b"MOVE HUB", b"You can now masturbate without searching for videos, mention the bot @MOVE_HUB_bot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_745f8f7895.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEHUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEHUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

