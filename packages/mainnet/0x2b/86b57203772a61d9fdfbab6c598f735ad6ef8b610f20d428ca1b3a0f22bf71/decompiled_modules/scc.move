module 0x2b86b57203772a61d9fdfbab6c598f735ad6ef8b610f20d428ca1b3a0f22bf71::scc {
    struct SCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCC>(arg0, 6, b"Scc", b"Suiberian Cat Coin", b"If you love cats and crypto, Siberian Cat Coin can be a fun way to participate in a growing cultural phenomenon. Siberian Cat Coin has the potential to increase significantly in value and its popularity continues to grow up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731129257035.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

