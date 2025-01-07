module 0xd58bb696396c0e5c3d9d834d5ac035ac78bb73c63785c7d632944d0cd8173693::trumpkamalawif {
    struct TRUMPKAMALAWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPKAMALAWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPKAMALAWIF>(arg0, 6, b"TRUMPKAMALAWIF", b"TRUMPKAMALA WIF HAT", b"Trump and Kamala join forces", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dubo_fwog_gm_b7d24c682f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPKAMALAWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPKAMALAWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

