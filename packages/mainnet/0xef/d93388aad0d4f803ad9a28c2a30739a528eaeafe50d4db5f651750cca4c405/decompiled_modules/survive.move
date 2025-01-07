module 0xefd93388aad0d4f803ad9a28c2a30739a528eaeafe50d4db5f651750cca4c405::survive {
    struct SURVIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURVIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURVIVE>(arg0, 6, b"Survive", b"suicide", b"meme token for heart broken peoples, let's dive in water(sui).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_ae_e_840a172ab6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURVIVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURVIVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

