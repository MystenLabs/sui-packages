module 0xc796ee3f4befaa36aee379a367c2cbe7d3d3ac2f00587a69eeb2e152b4f839a6::spn {
    struct SPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPN>(arg0, 6, b"SPN", b"Supernaturall", b"Two brothers Sam and Dean Winchester against the monsters of the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1760554935430.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

