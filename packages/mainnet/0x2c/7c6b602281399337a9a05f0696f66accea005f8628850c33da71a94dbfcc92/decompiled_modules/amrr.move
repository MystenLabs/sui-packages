module 0x2c7c6b602281399337a9a05f0696f66accea005f8628850c33da71a94dbfcc92::amrr {
    struct AMRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMRR>(arg0, 9, b"AMRR", b"Ammar", b"Ammartoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d63ec70e-84e7-4f78-8438-28ef4467b99d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

