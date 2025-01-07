module 0x4ed1570c0515e3e83383fed1ca75fd362a4ca372f4774c03a2babf7ba6652704::king {
    struct KING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING>(arg0, 6, b"King", b"Brett2.0", b"Trust the process", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734979307459.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

