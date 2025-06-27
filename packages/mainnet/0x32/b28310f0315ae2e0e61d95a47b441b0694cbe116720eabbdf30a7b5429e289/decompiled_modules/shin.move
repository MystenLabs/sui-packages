module 0x32b28310f0315ae2e0e61d95a47b441b0694cbe116720eabbdf30a7b5429e289::shin {
    struct SHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIN>(arg0, 6, b"Shin", b"SHINNOBISUI", b"Let's journey to the moon with the lone Shinobi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreichy2xwglpiu4tljphhltjsf547hfapn6kzr765la3vrjtkgp6z5a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

