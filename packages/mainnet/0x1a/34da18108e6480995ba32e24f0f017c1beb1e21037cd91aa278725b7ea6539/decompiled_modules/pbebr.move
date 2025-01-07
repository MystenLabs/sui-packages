module 0x1a34da18108e6480995ba32e24f0f017c1beb1e21037cd91aa278725b7ea6539::pbebr {
    struct PBEBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBEBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBEBR>(arg0, 9, b"PBEBR", b"jern", b"bcbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/70eb944c-daa8-4da4-9d50-87d143119167.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBEBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PBEBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

