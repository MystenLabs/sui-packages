module 0x288cdd95b5eee38dfecc30af2b692fc89163b185a0f2be9a939d0edc5882ec3::flo {
    struct FLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLO>(arg0, 9, b"FLO", b"Bio", b"red", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c44879f3-7582-432f-b035-4f7b661829ae-IMG_7128.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

