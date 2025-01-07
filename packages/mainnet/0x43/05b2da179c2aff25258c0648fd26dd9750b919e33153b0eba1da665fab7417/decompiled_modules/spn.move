module 0x4305b2da179c2aff25258c0648fd26dd9750b919e33153b0eba1da665fab7417::spn {
    struct SPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPN>(arg0, 9, b"SPN", b"scorpion", b"Very toxic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0981e146-9fbb-429f-be43-bbc9cb0d925a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPN>>(v1);
    }

    // decompiled from Move bytecode v6
}

