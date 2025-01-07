module 0xcf7df93272a3f1bfc400a5dece15679e893862f225e01bf614fb45eb68e4e504::sma {
    struct SMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMA>(arg0, 9, b"SMA", b"vann samba", b"blue with green", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97be9a87-82d7-4ed7-b04b-6e2e38936f66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

