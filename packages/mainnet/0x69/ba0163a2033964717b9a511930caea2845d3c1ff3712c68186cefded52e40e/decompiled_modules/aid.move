module 0x69ba0163a2033964717b9a511930caea2845d3c1ff3712c68186cefded52e40e::aid {
    struct AID has drop {
        dummy_field: bool,
    }

    fun init(arg0: AID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AID>(arg0, 9, b"AID", b"$LAM", b"For the Pinteresting", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb3caba0-3531-4a95-b453-f6e3d1bc4556.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AID>>(v1);
    }

    // decompiled from Move bytecode v6
}

