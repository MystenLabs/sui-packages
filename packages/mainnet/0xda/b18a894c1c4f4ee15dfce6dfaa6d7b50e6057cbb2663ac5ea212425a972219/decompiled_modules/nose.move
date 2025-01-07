module 0xdab18a894c1c4f4ee15dfce6dfaa6d7b50e6057cbb2663ac5ea212425a972219::nose {
    struct NOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOSE>(arg0, 9, b"NOSE", b"DOGNOSE", b"The nose of my Dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a9f9424-58fd-440b-88e9-be77bf3e96e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

