module 0x374d42a3160f8676da0a6bcce0877a48bfd003795bd2e9ce82254c6ce532837c::hh {
    struct HH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HH>(arg0, 6, b"HH", b"HH", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HH>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HH>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HH>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

