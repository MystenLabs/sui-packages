module 0x2b79820f18a8a58bca3f6fbd2ac30ae77a386bd4e2d84c6ec6487ca324a2d752::siren {
    struct SIREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIREN>(arg0, 6, b"SIREN", b"SIREN ", x"556e6d6174636865642070657273706963616369747920636f75706c6564207769746820736865657220696e646566617469676162696c697479206d616b6573206d65206120666561726564206f70706f6e656e7420696e20616e79207265616c6d206f662068756d616e20656e646561766f75722e20200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731061585364.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIREN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIREN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

