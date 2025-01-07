module 0x4c61fc55db93ecd12ff9cee3cac8dbbbe6de5fae8113f620bed094e6d22fd834::etalha {
    struct ETALHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETALHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETALHA>(arg0, 9, b"ETALHA", b"Talha", b"My Name Is Talha Aslam And I have a student.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec6c232d-1820-4b4b-be5a-9fdca13bcf1a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETALHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETALHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

