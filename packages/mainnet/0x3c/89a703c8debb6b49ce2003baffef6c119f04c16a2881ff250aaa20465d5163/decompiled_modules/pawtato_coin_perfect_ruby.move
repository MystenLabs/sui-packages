module 0x3c89a703c8debb6b49ce2003baffef6c119f04c16a2881ff250aaa20465d5163::pawtato_coin_perfect_ruby {
    struct PAWTATO_COIN_PERFECT_RUBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_PERFECT_RUBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_PERFECT_RUBY>(arg0, 9, b"PERFECT_RUBY", b"Pawtato Perfect Ruby", b"A Ruby with flawless clarity, ideal symmetry, and maximum brilliance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/ruby-perfect.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_PERFECT_RUBY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_PERFECT_RUBY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_perfect_ruby(arg0: 0x2::coin::Coin<PAWTATO_COIN_PERFECT_RUBY>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_PERFECT_RUBY>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

