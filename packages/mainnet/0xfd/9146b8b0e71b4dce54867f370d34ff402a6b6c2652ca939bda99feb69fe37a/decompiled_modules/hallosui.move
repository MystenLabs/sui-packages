module 0xfd9146b8b0e71b4dce54867f370d34ff402a6b6c2652ca939bda99feb69fe37a::hallosui {
    struct HALLOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLOSUI>(arg0, 6, b"Hallosui", b"Halloween on Sui", b"The spirit of Halloween has landed on Sui. Time to celebrate Halloween all year with $HALLOSUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hallosui_b47927f7a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALLOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

