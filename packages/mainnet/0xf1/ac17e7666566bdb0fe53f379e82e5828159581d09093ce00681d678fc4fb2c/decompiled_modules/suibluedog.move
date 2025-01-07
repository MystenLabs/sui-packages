module 0xf1ac17e7666566bdb0fe53f379e82e5828159581d09093ce00681d678fc4fb2c::suibluedog {
    struct SUIBLUEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBLUEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBLUEDOG>(arg0, 6, b"SUIBLUEDOG", b"blue eyes dog", b"the dog with a blue eyes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_162656388_b0b6f3ea27.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBLUEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBLUEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

