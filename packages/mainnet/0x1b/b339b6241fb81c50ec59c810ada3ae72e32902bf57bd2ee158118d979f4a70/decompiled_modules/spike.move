module 0x1bb339b6241fb81c50ec59c810ada3ae72e32902bf57bd2ee158118d979f4a70::spike {
    struct SPIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIKE>(arg0, 6, b"SPIKE", b"SPIKE!", x"426f797320636c756220676f742061206e6577206672656e21200a5350494b4520697320746865206669727374206f662074686520626f797320636c7562206f6e205355492e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_08_at_09_16_37_03818d66fc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

