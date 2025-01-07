module 0x1b55a96137652ae407626f7c9048799d4ef241dcd901043d674ae3819b5cedf1::kri {
    struct KRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRI>(arg0, 9, b"KRI", b"God Krishn", b"Goddess Krishna", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e49a518-7fcd-4e06-8931-52dd122d58c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRI>>(v1);
    }

    // decompiled from Move bytecode v6
}

