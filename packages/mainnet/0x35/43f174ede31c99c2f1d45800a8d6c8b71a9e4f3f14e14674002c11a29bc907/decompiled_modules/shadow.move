module 0x3543f174ede31c99c2f1d45800a8d6c8b71a9e4f3f14e14674002c11a29bc907::shadow {
    struct SHADOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHADOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHADOW>(arg0, 6, b"SHADOW", b"SHADOW ON SUI", b"In the depths of the decentralized web, where anonymity and transparency coexist, there is a figure known only by whispers on encrypted channels  Shadow SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_18_00_19_56_454d090064.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHADOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHADOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

