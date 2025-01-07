module 0x34e98d598bda5d5c7e5e924e7572895e4e8fb000f1834669e341719d062a9d90::hip {
    struct HIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIP>(arg0, 9, b"HIP", b"HipHip", b"Meme is meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8f769c9-d691-4ba6-a5b8-409c462cde04.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

