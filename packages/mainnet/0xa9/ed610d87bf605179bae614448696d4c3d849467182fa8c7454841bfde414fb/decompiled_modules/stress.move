module 0xa9ed610d87bf605179bae614448696d4c3d849467182fa8c7454841bfde414fb::stress {
    struct STRESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRESS>(arg0, 9, b"STRESS", b"Stress", b"Strees Heavy Stress", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d259bc9e-e1de-491c-8c25-a0875d053512.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

