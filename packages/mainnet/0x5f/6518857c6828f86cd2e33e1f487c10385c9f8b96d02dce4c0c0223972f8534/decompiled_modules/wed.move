module 0x5f6518857c6828f86cd2e33e1f487c10385c9f8b96d02dce4c0c0223972f8534::wed {
    struct WED has drop {
        dummy_field: bool,
    }

    fun init(arg0: WED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WED>(arg0, 9, b"WED", b"Wedeh", b"Trust is good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23aa7515-16c3-4182-a23f-6fea714da21d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WED>>(v1);
    }

    // decompiled from Move bytecode v6
}

