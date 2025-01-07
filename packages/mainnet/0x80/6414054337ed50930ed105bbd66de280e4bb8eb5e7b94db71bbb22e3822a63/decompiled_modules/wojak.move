module 0x806414054337ed50930ed105bbd66de280e4bb8eb5e7b94db71bbb22e3822a63::wojak {
    struct WOJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOJAK>(arg0, 8, b"WOJAK", b"OLD WOJAK", b"$WOJAK is the ultimate crypto thrill ride, tailor-made for the meme lords and market rebels of the crypto universe. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://harlequin-minimum-mouse-625.mypinata.cloud/ipfs/QmPdHw8G4SpCy7MSApPf9Axja265QR8KocX2U7Vxbmi3A4?_gl=1*ipu8zh*_ga*NTI5NTk3NDI4LjE3MDI1ODI0MzY.*_ga_5RMPXG14TE*MTcwMjYzOTg3My43LjEuMTcwMjYzOTg5Mi40MS4wLjA.")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOJAK>(&mut v2, 4200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOJAK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

