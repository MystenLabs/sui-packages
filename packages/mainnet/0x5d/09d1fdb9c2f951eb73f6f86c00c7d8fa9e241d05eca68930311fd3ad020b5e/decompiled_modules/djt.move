module 0x5d09d1fdb9c2f951eb73f6f86c00c7d8fa9e241d05eca68930311fd3ad020b5e::djt {
    struct DJT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJT>(arg0, 9, b"DJT", b"Djt", b"Donald. J. Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75ebfb3c-faf3-46ba-a5a2-727362b5502b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DJT>>(v1);
    }

    // decompiled from Move bytecode v6
}

