module 0x1228db69f6eb60c74ffa18c13c9a87ecfc53cac8af59ea08f53dce9b050efa02::wfe {
    struct WFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WFE>(arg0, 9, b"WFE", b"WIFEE", b"Ff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/36a2a51d-bb05-4fcb-87d8-e4437e0d1ebf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

