module 0x11ee389cb97d5af83568e2e433826854de51bf741218446bbbd71f2defc1db0::ddk {
    struct DDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDK>(arg0, 9, b"DDK", b"DODIK", b"this token describes your friend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7133faf8-bd0e-4434-9ce6-2ec603e612f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDK>>(v1);
    }

    // decompiled from Move bytecode v6
}

