module 0x7c953996434eac917b741a6598e8bb90faf5dcd53957549c616739c94b237ef1::pna {
    struct PNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNA>(arg0, 9, b"PNA", b"Pirana", b"This is the cutest pirana you have ever seen hope you like it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97486096-4c14-4383-a939-e4ae3d3212c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

