module 0xfa03670a43ef347a3ec0f615f0805bbd88c1435597875e76a9f10c525ebd0d8e::wecat {
    struct WECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WECAT>(arg0, 9, b"WECAT", b"WEWE", b"WEWE token is a cryptocurrency named after characters, individuals, animals, artwork, or anything else in an attempt to be humorous, light-hearted, and attract a user base by promising a fun community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ff6641e-9ed6-4c57-9f47-5b5d85ae3ab5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

