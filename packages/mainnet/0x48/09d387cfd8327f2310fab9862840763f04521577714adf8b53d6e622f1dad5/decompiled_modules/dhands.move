module 0x4809d387cfd8327f2310fab9862840763f04521577714adf8b53d6e622f1dad5::dhands {
    struct DHANDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHANDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHANDS>(arg0, 6, b"DHANDS", b"Diamonds Hands Sui", b"We Only Accept Diamond Hands Sui, no paper hands.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5257_adaa90afde.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHANDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DHANDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

