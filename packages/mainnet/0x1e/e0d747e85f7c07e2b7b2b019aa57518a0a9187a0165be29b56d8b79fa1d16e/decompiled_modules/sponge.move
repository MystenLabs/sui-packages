module 0x1ee0d747e85f7c07e2b7b2b019aa57518a0a9187a0165be29b56d8b79fa1d16e::sponge {
    struct SPONGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGE>(arg0, 6, b"Sponge", b"Sponge Coin", b"Fill this Sponge with Ca$h !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5796348001822819643_x_6ca1919aa0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPONGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

