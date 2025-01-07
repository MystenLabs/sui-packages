module 0xba15ff30d094e903ebd9fbc519c1550e134c6c7e4ccc66a3ccc5842ac351ed72::suiscl {
    struct SUISCL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISCL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISCL>(arg0, 9, b"SUISCL", b"SCLMEME", b"Its sui black chain token sui meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0a59566-afbc-49fd-9005-bc7d28ef5d94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISCL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISCL>>(v1);
    }

    // decompiled from Move bytecode v6
}

