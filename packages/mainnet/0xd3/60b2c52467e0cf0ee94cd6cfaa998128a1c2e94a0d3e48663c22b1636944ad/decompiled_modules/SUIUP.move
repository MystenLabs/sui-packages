module 0xd360b2c52467e0cf0ee94cd6cfaa998128a1c2e94a0d3e48663c22b1636944ad::SUIUP {
    struct SUIUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIUP>(arg0, 9, b"SUIUP", b"SUIUP", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIUP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIUP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIUP>>(0x2::coin::mint<SUIUP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

