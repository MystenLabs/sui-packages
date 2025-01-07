module 0x7f622a6cec0ff5e5275ae87fd3c11aed545bf25f42cdf23fd2ec46003377abc7::gh {
    struct GH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GH>(arg0, 9, b"GH", b"Poutine ", x"49e280996d20676f696e6720746f20626520696e20746f776e207468697320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5fcc88aa-58a3-4199-a70c-1e7c02078916.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GH>>(v1);
    }

    // decompiled from Move bytecode v6
}

