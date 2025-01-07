module 0xbf4991eead6921edf84816cf57d2a8514f6eff71c8c75b0b7e314b23061eb34a::conor {
    struct CONOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONOR>(arg0, 6, b"CONOR", b"Conor", b"$CONOR is a cat? a chad? a chat? I've heard it called the smartest cat in SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_20_43_58_4384c1c19d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CONOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

