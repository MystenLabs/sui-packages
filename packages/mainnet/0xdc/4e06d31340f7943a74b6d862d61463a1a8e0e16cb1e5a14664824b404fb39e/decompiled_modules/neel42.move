module 0xdc4e06d31340f7943a74b6d862d61463a1a8e0e16cb1e5a14664824b404fb39e::neel42 {
    struct NEEL42 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEEL42, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEEL42>(arg0, 9, b"NEEL42", b"neelhossai", b"ok, WEWE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82bf2f60-e6b2-4b10-afcb-9d29d9739918.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEEL42>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEEL42>>(v1);
    }

    // decompiled from Move bytecode v6
}

