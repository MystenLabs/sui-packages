module 0xc43932fa25c7f9fc8845373d722090dff3e3482996552326437b7b039d4f39bb::pwepe {
    struct PWEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWEPE>(arg0, 6, b"PWEPE", b"SUI PWEPE", b"meet $PWEPE, pepe but with latest update", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PWEPE_90b979b497.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

