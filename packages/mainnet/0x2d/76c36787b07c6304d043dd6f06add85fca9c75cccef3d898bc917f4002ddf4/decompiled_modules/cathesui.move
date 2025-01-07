module 0x2d76c36787b07c6304d043dd6f06add85fca9c75cccef3d898bc917f4002ddf4::cathesui {
    struct CATHESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATHESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATHESUI>(arg0, 6, b"CATHESUI", b"SUI CATHE", b"SUI CATHENAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_59_7e620a2d66.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATHESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATHESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

