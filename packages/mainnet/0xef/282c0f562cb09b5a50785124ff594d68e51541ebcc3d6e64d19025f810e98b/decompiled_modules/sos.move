module 0xef282c0f562cb09b5a50785124ff594d68e51541ebcc3d6e64d19025f810e98b::sos {
    struct SOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOS>(arg0, 6, b"SOS", b"Seal of Sui", b"Seal of SUI (SOS) is a community-driven, decentralized memecoin on the SUI blockchain that combines the spirit of trustworthiness and playful charm. Represented by an adorable, loyal seal, Seal of SUI is dedicated to creating a fun, accessible token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731145273547.24")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

