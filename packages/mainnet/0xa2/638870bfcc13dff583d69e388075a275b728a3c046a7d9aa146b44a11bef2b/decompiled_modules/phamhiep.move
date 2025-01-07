module 0xa2638870bfcc13dff583d69e388075a275b728a3c046a7d9aa146b44a11bef2b::phamhiep {
    struct PHAMHIEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHAMHIEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHAMHIEP>(arg0, 9, b"PHAMHIEP", b"Momo ", b"Im momo tokens ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d94889bf-bc87-4b63-901e-68d55be7aee0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHAMHIEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHAMHIEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

