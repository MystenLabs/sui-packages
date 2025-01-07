module 0x84e47b6dd5c4509ac5204089ef1293d90c07ade99ef696c2cc574b63dc8283ce::dc {
    struct DC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DC>(arg0, 6, b"DC", b"discord", b"discord meme coin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo6jupfeilyhx71_5623bd28ed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DC>>(v1);
    }

    // decompiled from Move bytecode v6
}

