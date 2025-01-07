module 0xcebb794ca0e4f41be030fb9d1b22f20baebd93f551251a796e3802bb1b94974b::sproto {
    struct SPROTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPROTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPROTO>(arg0, 6, b"SPROTO", b"Sproto Gremlin  $SPROTO", x"5370726f746f204772656d6c696e202d20245350524f544f0a0a4e657874205375696e6963204d6f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6498_b1dd8ba93c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPROTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPROTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

