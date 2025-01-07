module 0xc8d59aaf072a7fdfa90854156ea61c7fa3292042c6d157a24b24979c5aaa6f93::lmb {
    struct LMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMB>(arg0, 9, b"LMB", b"lambo", x"616e6f74686572206f6e652061626f7574206c616d626f636f696e0a52657620757020796f757220696e766573746d656e74732077697468207573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/957ee228-49f1-462d-89e0-8910bf0d3f96.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

