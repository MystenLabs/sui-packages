module 0xcf1307792e00df4467b04acea130544473b8decc86b19975cb3241adf3900f3d::pchk {
    struct PCHK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCHK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCHK>(arg0, 9, b"PCHK", b"ponch", b"PONCHIK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a24c913e-9e43-499d-b997-7873e7e46e06.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCHK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PCHK>>(v1);
    }

    // decompiled from Move bytecode v6
}

