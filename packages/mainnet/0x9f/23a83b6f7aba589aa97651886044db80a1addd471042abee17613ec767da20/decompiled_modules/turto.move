module 0x9f23a83b6f7aba589aa97651886044db80a1addd471042abee17613ec767da20::turto {
    struct TURTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTO>(arg0, 6, b"TURTO", b"Turto the Blue Turtle", b"Shellin' Out Laughs, One Meme at a Time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_91131e5c39.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

