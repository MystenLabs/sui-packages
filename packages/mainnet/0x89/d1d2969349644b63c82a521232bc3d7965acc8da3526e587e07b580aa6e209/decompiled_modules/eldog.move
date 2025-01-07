module 0x89d1d2969349644b63c82a521232bc3d7965acc8da3526e587e07b580aa6e209::eldog {
    struct ELDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELDOG>(arg0, 9, b"ELDOG", b"Elondog", b"X owner Elon dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/545a2930-2483-4273-b3b2-0bedf41bf771.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

