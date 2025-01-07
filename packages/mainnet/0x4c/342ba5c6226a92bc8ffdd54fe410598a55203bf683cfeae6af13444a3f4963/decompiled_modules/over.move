module 0x4c342ba5c6226a92bc8ffdd54fe410598a55203bf683cfeae6af13444a3f4963::over {
    struct OVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OVER>(arg0, 6, b"OVER", b"Its over", b"OVERR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732613747924.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OVER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OVER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

