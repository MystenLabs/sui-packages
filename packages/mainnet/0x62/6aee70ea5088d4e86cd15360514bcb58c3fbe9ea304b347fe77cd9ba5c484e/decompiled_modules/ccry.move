module 0x626aee70ea5088d4e86cd15360514bcb58c3fbe9ea304b347fe77cd9ba5c484e::ccry {
    struct CCRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCRY>(arg0, 9, b"CCRY", b"CATCRY", b"Why airdrop ban me :< ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c23108b8-f271-4083-9868-15df5186c779.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

