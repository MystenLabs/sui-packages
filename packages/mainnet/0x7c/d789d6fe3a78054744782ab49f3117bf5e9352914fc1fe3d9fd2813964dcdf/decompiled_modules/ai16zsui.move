module 0x7cd789d6fe3a78054744782ab49f3117bf5e9352914fc1fe3d9fd2813964dcdf::ai16zsui {
    struct AI16ZSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI16ZSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI16ZSUI>(arg0, 6, b"Ai16zSui", b"Ai16z SUI", x"616931367a656c697a61206c6f676f0a616931367a656c697a612028656c697a61290a456c697a61206d616465206f6e20456c697a612e20506f77657265642062792040767661696675646f7466756e204d6164652077697468207676616966752e66756e20437265617465204149204167656e7473207769746820746f6b656e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000082_fd9525e20c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI16ZSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI16ZSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

