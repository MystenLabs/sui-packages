module 0x18f096d4898575c83a909d012e66a450729154e43d4268a6e122277bd1240ca2::upbo {
    struct UPBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPBO>(arg0, 9, b"UPBO", b"UPB", b"Banggg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbb6774d-8773-4e6a-9cc1-dfde975eb039.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UPBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

