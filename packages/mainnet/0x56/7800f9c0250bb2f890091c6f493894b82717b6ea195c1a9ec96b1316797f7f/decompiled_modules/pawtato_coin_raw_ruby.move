module 0x567800f9c0250bb2f890091c6f493894b82717b6ea195c1a9ec96b1316797f7f::pawtato_coin_raw_ruby {
    struct PAWTATO_COIN_RAW_RUBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_RAW_RUBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_RAW_RUBY>(arg0, 9, b"RAW_RUBY", b"Pawtato Raw Ruby", b"An uncut and unpolished Ruby, showing its natural shape and rough surface.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/ruby-raw.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_RAW_RUBY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_RAW_RUBY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_raw_ruby(arg0: 0x2::coin::Coin<PAWTATO_COIN_RAW_RUBY>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_RAW_RUBY>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

