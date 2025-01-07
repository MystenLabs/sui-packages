module 0x13026f5d5cb1bbc77ff35cc2ce7036a1df0fe96f688dcf2dc780efbf84b19b4c::sme {
    struct SME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SME>(arg0, 9, b"SME", b"Sam Meme", b"A Meme token for Sam and Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1048f90a-ef81-4658-b3d4-1290f2e58c11.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SME>>(v1);
    }

    // decompiled from Move bytecode v6
}

