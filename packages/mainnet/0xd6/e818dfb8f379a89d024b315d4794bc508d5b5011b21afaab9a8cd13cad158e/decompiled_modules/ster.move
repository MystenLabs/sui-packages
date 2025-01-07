module 0xd6e818dfb8f379a89d024b315d4794bc508d5b5011b21afaab9a8cd13cad158e::ster {
    struct STER has drop {
        dummy_field: bool,
    }

    fun init(arg0: STER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STER>(arg0, 6, b"STER", b"Stermonster sui", b"HEY, I AM STERMON. IM A MONSTER, NOT A TYPICAL SCARY ONE, BUT A NICE FRIEND TO EVERYONE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241214_172114_a713844cf9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STER>>(v1);
    }

    // decompiled from Move bytecode v6
}

