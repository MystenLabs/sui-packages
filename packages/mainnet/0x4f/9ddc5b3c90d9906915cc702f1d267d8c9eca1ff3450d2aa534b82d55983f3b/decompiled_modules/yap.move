module 0x4f9ddc5b3c90d9906915cc702f1d267d8c9eca1ff3450d2aa534b82d55983f3b::yap {
    struct YAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAP>(arg0, 6, b"YAP", b"YAPPER", x"224869212049276d20596170706572212049276d2038207965617273206f6c6420616e642049206c6f766520706c6179696e6720766964656f2067616d657320616e6420726964696e67206d792073636f6f7465722e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pop_Cat_GIF_25a9ffd234.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

