module 0x9c21aef4b9175eda951fb52db56a1c20d4651cde398084286bc00fb1602e0625::hakuma {
    struct HAKUMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAKUMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAKUMA>(arg0, 6, b"HAKUMA", b"Hakuma on Sui", b"The token that came to set you free from worries feel free to invest in Hakuma. Everything will be fine.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735462431198.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAKUMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAKUMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

