module 0xd63cc10d0397e578b7b2d3382d9595903f290b36c48268aa17b44d36148acd10::pawtato_coin_ruby {
    struct PAWTATO_COIN_RUBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_RUBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_RUBY>(arg0, 9, b"RUBY", b"Pawtato Ruby", b"A properly cut and polished Ruby, offering clear color and radiance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/ruby.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_RUBY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_RUBY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_ruby(arg0: 0x2::coin::Coin<PAWTATO_COIN_RUBY>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_RUBY>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

