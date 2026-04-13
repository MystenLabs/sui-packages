module 0x4a4f8dc24177756dbec4d04599f7bad99e727b3e5ec8f25ca5c99712cbcd80a2::marco_protocol {
    struct MARCO_PROTOCOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARCO_PROTOCOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARCO_PROTOCOL>(arg0, 9, b"MARCO", b"Marco Protocol", b"Marco", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776087070132-06f649c5eccfc0d7b39e14dc0a8357b1.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MARCO_PROTOCOL>>(0x2::coin::mint<MARCO_PROTOCOL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARCO_PROTOCOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARCO_PROTOCOL>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

