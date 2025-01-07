module 0xa4dbc789422e2df53d1b339d22a1fedad8f93260f37428c55eec386f166911a7::gecat {
    struct GECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GECAT>(arg0, 9, b"GECAT", b"KWET", b"KWET is a meme inspired by the spirit of adventure and freedom. You can never be wrong with KWET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8a8fd78-9872-4e2e-9e09-05f2dd1f8984.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

