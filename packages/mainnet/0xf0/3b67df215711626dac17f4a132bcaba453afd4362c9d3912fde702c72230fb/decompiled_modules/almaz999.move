module 0xf03b67df215711626dac17f4a132bcaba453afd4362c9d3912fde702c72230fb::almaz999 {
    struct ALMAZ999 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALMAZ999, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALMAZ999>(arg0, 9, b"Almaz999", b"Seruy999", b"Fire", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/741256ac616def417b98958e1b662891blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALMAZ999>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALMAZ999>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

