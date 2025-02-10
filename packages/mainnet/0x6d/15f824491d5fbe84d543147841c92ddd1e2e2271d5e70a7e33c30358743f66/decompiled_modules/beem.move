module 0x6d15f824491d5fbe84d543147841c92ddd1e2e2271d5e70a7e33c30358743f66::beem {
    struct BEEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEM>(arg0, 9, b"BEEM", b"Beem", b"J4F", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d7ca4d9b-bb41-4f90-ba05-68828ae4ba55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

