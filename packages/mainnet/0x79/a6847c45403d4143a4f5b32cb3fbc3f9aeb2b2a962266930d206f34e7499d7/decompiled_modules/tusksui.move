module 0x79a6847c45403d4143a4f5b32cb3fbc3f9aeb2b2a962266930d206f34e7499d7::tusksui {
    struct TUSKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUSKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSKSUI>(arg0, 6, b"TUSKSUI", b"TUSK THE WALRUS", b"Walrus Cult of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_18_052844781_2428869480.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUSKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

