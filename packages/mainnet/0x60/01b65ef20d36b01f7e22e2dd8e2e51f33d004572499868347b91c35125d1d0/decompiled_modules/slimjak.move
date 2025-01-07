module 0x6001b65ef20d36b01f7e22e2dd8e2e51f33d004572499868347b91c35125d1d0::slimjak {
    struct SLIMJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIMJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIMJAK>(arg0, 6, b"SLIMJAK", b"Slimjak On Sui", b"Slimjak is Wojak's skinny twin brother that became a global meme icon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_442f5dd212.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIMJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIMJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

