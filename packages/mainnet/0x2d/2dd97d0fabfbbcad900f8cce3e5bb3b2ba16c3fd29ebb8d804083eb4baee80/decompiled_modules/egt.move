module 0x2d2dd97d0fabfbbcad900f8cce3e5bb3b2ba16c3fd29ebb8d804083eb4baee80::egt {
    struct EGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGT>(arg0, 9, b"EGT", b"Eaglet", b"Eaglet meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2806f13d-d651-47cb-970f-f5a882480859.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

