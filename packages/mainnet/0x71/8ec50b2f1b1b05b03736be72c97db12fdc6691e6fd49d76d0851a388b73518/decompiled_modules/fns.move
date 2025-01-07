module 0x718ec50b2f1b1b05b03736be72c97db12fdc6691e6fd49d76d0851a388b73518::fns {
    struct FNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNS>(arg0, 9, b"FNS", b"FINES", b"Adventure-time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8e6b0283-deff-4d65-9be0-3015298a8f9d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

