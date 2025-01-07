module 0xe270696faadf7db4129913820ddd0c91528eb54871d396fdb9aab4834ef5f56f::dm {
    struct DM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DM>(arg0, 9, b"DM", b"Doremon", b"This token come from future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba43eaed-885b-4cb7-80a0-e7cbe46ade4e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DM>>(v1);
    }

    // decompiled from Move bytecode v6
}

