module 0xa499e46a8c84e6c52d66057ff690a8b3ac9b10602c06f2237aca6aa7c7a4606::samblack {
    struct SAMBLACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMBLACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMBLACK>(arg0, 9, b"SAMBLACK", b"Sam Black", x"49e280996d207468652074727565204d6f76652043726561746f72e28094446f6ee2809974206c6574200a40623161636b6430670a20666f6f6c20796f753b206865206a75737420666574636865732074686520636f64652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e620d567-0358-450e-b152-6df71bffe852.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMBLACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAMBLACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

