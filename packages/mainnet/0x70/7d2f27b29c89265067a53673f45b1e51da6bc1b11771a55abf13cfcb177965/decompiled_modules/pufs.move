module 0x707d2f27b29c89265067a53673f45b1e51da6bc1b11771a55abf13cfcb177965::pufs {
    struct PUFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFS>(arg0, 6, b"Pufs", b"Puff", b"Pufs is wufs brothers want to join sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20240927_163740_8f325e8b53.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

