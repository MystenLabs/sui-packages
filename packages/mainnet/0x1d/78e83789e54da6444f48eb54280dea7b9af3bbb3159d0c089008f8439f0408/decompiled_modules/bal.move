module 0x1d78e83789e54da6444f48eb54280dea7b9af3bbb3159d0c089008f8439f0408::bal {
    struct BAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAL>(arg0, 9, b"BAL", b"ball", b"ball ball ball", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1a1275728c577a80599414e9f894fc7cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

