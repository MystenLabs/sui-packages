module 0x789082924ccb18c8f0ebba3c94705587930c4e688ea5e401ea56e8e8c34bab7a::zelda {
    struct ZELDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZELDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZELDA>(arg0, 6, b"ZELDA", b"ZELDA | The Warrior Cat", b"The Warrior Cat! Meet ZELDA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_f453f9b6f3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZELDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZELDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

