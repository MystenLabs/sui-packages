module 0x30180757c95dd586f5ea0178fab253d51cbf84a9d56e356bacd1e54f0c4b07e5::sal_5 {
    struct SAL_5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAL_5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAL_5>(arg0, 9, b"SAL_5", b"Saloy", b"Meeeed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/71d0f034-b5aa-4d6f-8e99-d8d2d70adcde.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAL_5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAL_5>>(v1);
    }

    // decompiled from Move bytecode v6
}

