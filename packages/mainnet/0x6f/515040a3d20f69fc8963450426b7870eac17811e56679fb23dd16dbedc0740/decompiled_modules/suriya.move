module 0x6f515040a3d20f69fc8963450426b7870eac17811e56679fb23dd16dbedc0740::suriya {
    struct SURIYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURIYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURIYA>(arg0, 6, b"Suriya", b"Suriya Suuheart", b"Bending the Boundaries of Reality: Suu Monsters at My Side!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6891_b7b3b12aea.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURIYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURIYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

