module 0x605887bd53d39fb5220635ab393001199540234ef4db516a460e666cb54a53b6::moonlite {
    struct MOONLITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONLITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONLITE>(arg0, 6, b"Moonlite", b"Moonlite Bot", b"Meet Moonlite, The first ever Telegram Trading bot for the Sui blockchain. Rev share will be enabled for holders following our first week of beta testing!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/De_Q_3wf_B_400x400_083707ee5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONLITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONLITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

