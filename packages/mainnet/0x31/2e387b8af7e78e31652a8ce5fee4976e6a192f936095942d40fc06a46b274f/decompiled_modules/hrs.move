module 0x312e387b8af7e78e31652a8ce5fee4976e6a192f936095942d40fc06a46b274f::hrs {
    struct HRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRS>(arg0, 9, b"HRS", b"Horse meme", b"Brown Horse meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1195c8a5-2f5b-4e63-806b-deb233b3427a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

