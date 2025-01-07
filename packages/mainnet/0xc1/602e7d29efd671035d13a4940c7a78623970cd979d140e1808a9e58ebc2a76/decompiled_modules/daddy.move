module 0xc1602e7d29efd671035d13a4940c7a78623970cd979d140e1808a9e58ebc2a76::daddy {
    struct DADDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADDY>(arg0, 6, b"Daddy", b"Daddy Sui", b"The DADDY stays wet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731692797778.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DADDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

