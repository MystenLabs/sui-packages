module 0xd12bc14ed4e6650f2571d3db98be230dd8855c5741b911c91c0e3059c9e96e07::suinu {
    struct SUINU has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 8, b"SUINU", b"SUINU", b"SUINU: Unleash the Power of Loyalty and Fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tinyurl.com/suinua")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SUINU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SUINU>(arg0, arg1);
        0x2::coin::mint_and_transfer<SUINU>(&mut v0, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUINU>>(v0);
    }

    // decompiled from Move bytecode v6
}

