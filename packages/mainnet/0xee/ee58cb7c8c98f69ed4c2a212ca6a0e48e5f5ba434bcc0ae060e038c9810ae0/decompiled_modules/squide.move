module 0xeeee58cb7c8c98f69ed4c2a212ca6a0e48e5f5ba434bcc0ae060e038c9810ae0::squide {
    struct SQUIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDE>(arg0, 6, b"Squide", b"Squide On Sui", b"Squide The Pearl OF SUI, The cryptocurrency market on the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SQUIDE_3420c0b488.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

