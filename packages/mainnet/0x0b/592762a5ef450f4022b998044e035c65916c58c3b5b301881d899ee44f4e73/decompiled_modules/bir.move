module 0xb592762a5ef450f4022b998044e035c65916c58c3b5b301881d899ee44f4e73::bir {
    struct BIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIR>(arg0, 6, b"BIR", b"Bitch I'm Rich", b"Bitch, I'm Rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732496231464.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

