module 0xc69d583739b50cf4146d9882d476909c12572bebc19fc82a76a51fbcaeecf544::cld {
    struct CLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLD>(arg0, 9, b"CLD", b"the cloud", b"With a dream brand", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6639738b-2162-4e4b-afdf-4805ddd01826.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

