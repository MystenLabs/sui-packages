module 0x8801906d224283307015968bc4e8b9759cbe49987e9070d948582c9486bddca7::fc {
    struct FC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FC>(arg0, 9, b"FC", b"Fuck Cat", b"Fuck Cat because cat fuck ogs ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/57a75312-f6b9-4acf-a29c-38956cd91fa7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FC>>(v1);
    }

    // decompiled from Move bytecode v6
}

