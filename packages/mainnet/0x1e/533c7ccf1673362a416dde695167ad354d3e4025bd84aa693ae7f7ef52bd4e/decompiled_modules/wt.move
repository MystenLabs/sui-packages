module 0x1e533c7ccf1673362a416dde695167ad354d3e4025bd84aa693ae7f7ef52bd4e::wt {
    struct WT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WT>(arg0, 9, b"WT", b"Water", b"Waters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f4404cbc-598c-435e-b46d-5c488441e0b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WT>>(v1);
    }

    // decompiled from Move bytecode v6
}

