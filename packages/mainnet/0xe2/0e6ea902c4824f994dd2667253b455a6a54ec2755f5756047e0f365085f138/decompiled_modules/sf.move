module 0xe20e6ea902c4824f994dd2667253b455a6a54ec2755f5756047e0f365085f138::sf {
    struct SF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SF>(arg0, 9, b"SF", b"S", b"VCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8706b9bb-22d5-4cee-90ff-e16c1ec7c758.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SF>>(v1);
    }

    // decompiled from Move bytecode v6
}

