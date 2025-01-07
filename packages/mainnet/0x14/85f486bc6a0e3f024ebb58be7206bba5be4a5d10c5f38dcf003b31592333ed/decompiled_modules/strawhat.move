module 0x1485f486bc6a0e3f024ebb58be7206bba5be4a5d10c5f38dcf003b31592333ed::strawhat {
    struct STRAWHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRAWHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRAWHAT>(arg0, 6, b"STRAWHAT", b"StrawHat Luffy", b"Inspired by the legendary anime One Piece, StrawHat is a memecoin on the Sui Network, inviting users on an exciting journey toward decentralized freedom. Join our community of pirates, explore the seas of meme, and discover the treasure that awaits.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241003_160730_69a2e797c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRAWHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRAWHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

