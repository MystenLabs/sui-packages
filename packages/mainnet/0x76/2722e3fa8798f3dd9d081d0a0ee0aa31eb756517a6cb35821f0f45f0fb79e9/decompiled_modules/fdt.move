module 0x762722e3fa8798f3dd9d081d0a0ee0aa31eb756517a6cb35821f0f45f0fb79e9::fdt {
    struct FDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDT>(arg0, 9, b"FDT", b"Food", b"Foodchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78805df1-c8a9-4945-99b7-02950c7566d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

