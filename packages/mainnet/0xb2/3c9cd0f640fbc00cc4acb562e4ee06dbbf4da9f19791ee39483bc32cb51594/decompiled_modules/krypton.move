module 0xb23c9cd0f640fbc00cc4acb562e4ee06dbbf4da9f19791ee39483bc32cb51594::krypton {
    struct KRYPTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRYPTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRYPTON>(arg0, 6, b"KRYPTON", b"SUIPERMAN", b"Suiperman is the symbol of hope and justice, a hero who inspires courage in everyone with his suiperhuman strength and an immensely human heart.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_38_1bcb7ddcae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRYPTON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRYPTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

