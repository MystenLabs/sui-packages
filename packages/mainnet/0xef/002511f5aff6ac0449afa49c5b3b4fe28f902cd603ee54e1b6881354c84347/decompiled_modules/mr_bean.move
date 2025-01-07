module 0xef002511f5aff6ac0449afa49c5b3b4fe28f902cd603ee54e1b6881354c84347::mr_bean {
    struct MR_BEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MR_BEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MR_BEAN>(arg0, 9, b"MR_BEAN", b"BEAN", b"a token dedicated to Mr. Bean a guy who made our childhood awesome ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8880ee1d-5b72-4593-aaf9-2f2ed4476736.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MR_BEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MR_BEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

