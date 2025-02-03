module 0xe26eeb3396b8e9309c10dbf2e611701c2210ef24aafe46e8a232a71f97bbe832::dottu {
    struct DOTTU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOTTU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOTTU>(arg0, 6, b"DOTTU", b"Don't bye", b"don't bye", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738591331635.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOTTU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOTTU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

