module 0xf2f3fb4be13937f23e75e6b3537d853101bafa19c524cdee2fe84d4430424af5::prs {
    struct PRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRS>(arg0, 6, b"PRS", b"Power Ranger Sui", x"49742773204d6f727068696e2054696d6521212121210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_39_526d421ce8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

