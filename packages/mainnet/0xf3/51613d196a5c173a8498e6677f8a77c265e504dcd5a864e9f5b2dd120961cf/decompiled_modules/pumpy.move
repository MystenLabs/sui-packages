module 0xf351613d196a5c173a8498e6677f8a77c265e504dcd5a864e9f5b2dd120961cf::pumpy {
    struct PUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPY>(arg0, 6, b"PUMPY", b"Pumpy Token", b"Best Meme Token On Sui Network From Airdrop Hunter ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003511_e7f35e0695.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

