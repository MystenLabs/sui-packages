module 0x4971a456ec717600aba329f336387b89211e76c3d9bbc249bb8f47f19641adba::trumpbull {
    struct TRUMPBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPBULL>(arg0, 9, b"TRUMPBULL", b"UPTRUMP", b"Donal Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/960fd085-caa8-497b-8486-3bfe902cb97e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

