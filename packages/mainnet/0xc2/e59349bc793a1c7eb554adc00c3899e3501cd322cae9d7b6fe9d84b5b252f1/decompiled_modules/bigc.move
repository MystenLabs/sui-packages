module 0xc2e59349bc793a1c7eb554adc00c3899e3501cd322cae9d7b6fe9d84b5b252f1::bigc {
    struct BIGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGC>(arg0, 9, b"BIGC", b"Bigcock", b"Bigcock fan girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10d2160e-367b-4e9d-89d4-76b590be31bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

