module 0x58a08ab7fa43529f60fb843f65a8e888b67c34b4282d0bc176a1ccc847a5454f::rbt {
    struct RBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBT>(arg0, 9, b"RBT", b"ROBOT", b"this robot need fuel to move buy fuel for it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8e558295-f2e6-400a-acef-92a1f4e596cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

