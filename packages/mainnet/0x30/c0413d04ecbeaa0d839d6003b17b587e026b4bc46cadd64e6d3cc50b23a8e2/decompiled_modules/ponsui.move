module 0x30c0413d04ecbeaa0d839d6003b17b587e026b4bc46cadd64e6d3cc50b23a8e2::ponsui {
    struct PONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONSUI>(arg0, 9, b"PONSUI", b"Ponsui Iluminati", b"Nobody knows who is behind. Coins were airdroped and started to pay immediately.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blob.suiget.xyz/uploads/img_680af4e9828e56.76768476.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

