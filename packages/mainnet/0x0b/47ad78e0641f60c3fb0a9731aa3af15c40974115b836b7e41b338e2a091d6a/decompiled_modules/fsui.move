module 0xb47ad78e0641f60c3fb0a9731aa3af15c40974115b836b7e41b338e2a091d6a::fsui {
    struct FSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSUI>(arg0, 6, b"FSUI", b"Flame Sui", b"Ride the blue flame on the Sui Chain with FlameSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_aea1d344df.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

