module 0x3ef2330eee9796ff173ffea0410a84919bc2c86976964af1eed7ee573b8e833::dognald {
    struct DOGNALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGNALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGNALD>(arg0, 6, b"DOGNALD", b"First Dognald Trump On Sui", b"First Dognald Trump On Sui: https://dognaldtrumponsui.mom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_41_169f3ad67f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGNALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGNALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

