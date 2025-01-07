module 0x4a86509abecd24f4967f8553b54ecb43c5192bec77210cfa4107934d8e56b89a::qing {
    struct QING has drop {
        dummy_field: bool,
    }

    fun init(arg0: QING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QING>(arg0, 6, b"Qing", b"Biao Qing", b"F*ck All", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/panda_removebg_preview_78f3575a73.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QING>>(v1);
    }

    // decompiled from Move bytecode v6
}

