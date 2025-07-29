module 0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::vaultlpt {
    struct VAULTLPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAULTLPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAULTLPT>(arg0, 9, b"haSUI-SUI Vault LPT", b"haSUI-SUI Haedal Vault LP Token", b"Haedal Vault LP Token, haSUI-SUI Loop Strategy Pool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.haedal.xyz/logos/vault_lpt.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAULTLPT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAULTLPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

