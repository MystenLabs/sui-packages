module 0xd081826b536cd99b9e64483b9529c40bc1acc0d01f1ba53f0238ac4dbd106283::suibruce {
    struct SUIBRUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBRUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBRUCE>(arg0, 6, b"SUIBRUCE", b"Sui Bruce", x"42652077617465722e0a0a4265205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bruce_9fa9c3dab3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBRUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBRUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

