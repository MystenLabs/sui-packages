module 0xc9bb33c7008c708b558f46941773d38fdef3d53610667b9d3b9e318077a1da2d::bbull {
    struct BBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBULL>(arg0, 6, b"BBULL", b"Blue Bull", x"4d65657420426c75652042756c6c2c2074686520756e73746f707061626c652063727970746f20666f726365206f6e2074686520535549204e6574776f726b2e20496620796f75e28099726520726561647920746f20726964652c207468656e20426c75652042756c6c20697320796f75722067757921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731539329327.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBULL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBULL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

