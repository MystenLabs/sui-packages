module 0xc0267935e5ad2f19e783e980b36003339c839716a9fe0c2beca81b4e79e83847::grump {
    struct GRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUMP>(arg0, 6, b"GRUMP", b"GRUMP SUI", b"Sui Grump Wanna get high? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731227076250.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

