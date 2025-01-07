module 0x6328974e72c42666e7c7fa61ec6e7f1e06e87e737c6af1595c48ff86f0cf99a0::supe {
    struct SUPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPE>(arg0, 6, b"SUPE", b"SUI PEPE", b"$SUPE Sui Pepe Now launch on Suichain movepump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_pepe_2b9c80b5af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

