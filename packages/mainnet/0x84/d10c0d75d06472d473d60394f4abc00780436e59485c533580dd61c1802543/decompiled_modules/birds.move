module 0x84d10c0d75d06472d473d60394f4abc00780436e59485c533580dd61c1802543::birds {
    struct BIRDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDS>(arg0, 9, b"BIRDS", b"Birds", b"The leading Memecoin & GameFi Telegram mini-app on the @SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/317b14cd-b180-4203-95d4-c9c8ed06b29d-IMG_0018.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIRDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

