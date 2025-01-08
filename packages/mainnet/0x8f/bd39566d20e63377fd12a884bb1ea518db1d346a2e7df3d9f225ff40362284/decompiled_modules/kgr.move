module 0x8fbd39566d20e63377fd12a884bb1ea518db1d346a2e7df3d9f225ff40362284::kgr {
    struct KGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KGR>(arg0, 6, b"KGR", b"kagura sui", b"choose me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736371545386.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KGR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KGR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

