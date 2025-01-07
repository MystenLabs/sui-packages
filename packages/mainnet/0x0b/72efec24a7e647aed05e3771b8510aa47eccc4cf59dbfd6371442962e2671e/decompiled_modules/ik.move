module 0xb72efec24a7e647aed05e3771b8510aa47eccc4cf59dbfd6371442962e2671e::ik {
    struct IK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IK>(arg0, 9, b"IK", b"Ik804", b"Boss ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/044896bd-c343-4dec-b9c7-51723b3928c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IK>>(v1);
    }

    // decompiled from Move bytecode v6
}

