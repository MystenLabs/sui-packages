module 0xfe4c65055bcf502426216d51d68491a29c7663622fac12762a945e1f3a22f1fd::survive {
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

