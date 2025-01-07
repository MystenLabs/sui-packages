module 0xa140d643a8a5ecfbde23790bf0eed132da9c8952e9ac9d7054ea22b6aeaf3880::catcry {
    struct CATCRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCRY>(arg0, 9, b"CATCRY", b"CatCry", b"Why airdrop ban me :< ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a25a784-6de7-4fcc-9364-dd73f0c342a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATCRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

