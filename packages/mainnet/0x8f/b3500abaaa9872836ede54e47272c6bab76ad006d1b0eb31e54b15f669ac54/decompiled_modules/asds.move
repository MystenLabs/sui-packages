module 0x8fb3500abaaa9872836ede54e47272c6bab76ad006d1b0eb31e54b15f669ac54::asds {
    struct ASDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDS>(arg0, 9, b"ASDS", b"SAF", b"DS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d34e054-ec39-4f67-97ff-d2e01ea7e01c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

