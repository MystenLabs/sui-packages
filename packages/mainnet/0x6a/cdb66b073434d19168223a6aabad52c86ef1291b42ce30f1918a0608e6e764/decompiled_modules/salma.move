module 0x6acdb66b073434d19168223a6aabad52c86ef1291b42ce30f1918a0608e6e764::salma {
    struct SALMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALMA>(arg0, 9, b"SALMA", b"Hon", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2367c2fe-b229-453e-94bd-9832cb748193.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SALMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

