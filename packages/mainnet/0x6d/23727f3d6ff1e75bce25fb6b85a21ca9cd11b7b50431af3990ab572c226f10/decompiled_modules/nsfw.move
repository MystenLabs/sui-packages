module 0x6d23727f3d6ff1e75bce25fb6b85a21ca9cd11b7b50431af3990ab572c226f10::nsfw {
    struct NSFW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSFW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSFW>(arg0, 6, b"NSFW", b"Not SUItable for work", b"Sssuiexxx is not suitable for work", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7615_ef5837ae1b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSFW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NSFW>>(v1);
    }

    // decompiled from Move bytecode v6
}

