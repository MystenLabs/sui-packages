module 0xd899fc2d35645bcd03dcf435e6a8995ff7af1d0518489891d065eed05feb54bf::stmaxa {
    struct STMAXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STMAXA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STMAXA>(arg0, 9, b"STMAXA", b"Stmax", b"Stma----SSSSSSSSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af34c5f6-98ca-4b58-8efb-03720bbb900d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STMAXA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STMAXA>>(v1);
    }

    // decompiled from Move bytecode v6
}

