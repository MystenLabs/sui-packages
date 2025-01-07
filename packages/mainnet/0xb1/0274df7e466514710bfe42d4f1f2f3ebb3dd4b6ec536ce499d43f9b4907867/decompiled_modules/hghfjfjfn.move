module 0xb10274df7e466514710bfe42d4f1f2f3ebb3dd4b6ec536ce499d43f9b4907867::hghfjfjfn {
    struct HGHFJFJFN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HGHFJFJFN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HGHFJFJFN>(arg0, 9, b"HGHFJFJFN", b"Vehdhshs", b"Hdhshshshsh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5633430-d597-48ca-940f-d1516e72f912.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HGHFJFJFN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HGHFJFJFN>>(v1);
    }

    // decompiled from Move bytecode v6
}

