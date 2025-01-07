module 0xa9e2acafe438ed901f9e304895b5928e91df4945767e123bd4a5e89ed38659da::trl {
    struct TRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRL>(arg0, 9, b"TRL", b"TURTLE", b"Turtle Coin is a community-driven, decentralized cryptocurrency prioritizing security, accessibility, and slow-and-steady growth. Inspired by the turtle's steady pace, TRL aims to provide a stable store of value and medium of exchange.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a4e6699-4b40-412c-be32-369dd2b9f775.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

