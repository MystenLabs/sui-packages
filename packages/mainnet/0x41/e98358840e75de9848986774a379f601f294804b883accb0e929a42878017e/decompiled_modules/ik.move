module 0x41e98358840e75de9848986774a379f601f294804b883accb0e929a42878017e::ik {
    struct IK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IK>(arg0, 9, b"IK", b"Qaidi804", b"In honour of great Imran Khan ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be8482e5-7137-4b25-8069-9a6d70798e50.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IK>>(v1);
    }

    // decompiled from Move bytecode v6
}

