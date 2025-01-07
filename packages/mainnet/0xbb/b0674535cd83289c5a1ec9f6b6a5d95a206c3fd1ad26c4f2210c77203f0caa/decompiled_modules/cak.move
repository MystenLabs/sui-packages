module 0xbbb0674535cd83289c5a1ec9f6b6a5d95a206c3fd1ad26c4f2210c77203f0caa::cak {
    struct CAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAK>(arg0, 6, b"CAK", b"Blue Cack On Sui", b"Blue Cack", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956380280.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

