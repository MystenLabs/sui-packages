module 0x970d31c96e098ab41d566c643c9acbf496983cbfc6b51da6620410d2287ee230::ori {
    struct ORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORI>(arg0, 6, b"ORI", b"Origent AI", b"we host a decentralized network of autonomous AI agents capable of performing complex tasks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738763675198.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

