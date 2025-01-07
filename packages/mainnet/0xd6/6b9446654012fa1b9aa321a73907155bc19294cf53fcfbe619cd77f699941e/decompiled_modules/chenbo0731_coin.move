module 0xd66b9446654012fa1b9aa321a73907155bc19294cf53fcfbe619cd77f699941e::chenbo0731_coin {
    struct CHENBO0731_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHENBO0731_COIN>, arg1: 0x2::coin::Coin<CHENBO0731_COIN>) {
        0x2::coin::burn<CHENBO0731_COIN>(arg0, arg1);
    }

    fun init(arg0: CHENBO0731_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHENBO0731_COIN>(arg0, 6, b"chenbo0731_coin", b"cc", b"learning for letsmove, power by chenbo0731", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-d12507e471ea44b89eaa8d48d6397520.r2.dev/joker.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHENBO0731_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHENBO0731_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHENBO0731_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHENBO0731_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

