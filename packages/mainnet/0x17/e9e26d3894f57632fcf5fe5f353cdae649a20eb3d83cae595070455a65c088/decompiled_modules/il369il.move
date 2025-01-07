module 0x17e9e26d3894f57632fcf5fe5f353cdae649a20eb3d83cae595070455a65c088::il369il {
    struct IL369IL has drop {
        dummy_field: bool,
    }

    fun init(arg0: IL369IL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IL369IL>(arg0, 9, b"IL369IL", b"369", b"3 6 9 *_*", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ebadda3-9751-4bf1-a511-58d8244c36e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IL369IL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IL369IL>>(v1);
    }

    // decompiled from Move bytecode v6
}

