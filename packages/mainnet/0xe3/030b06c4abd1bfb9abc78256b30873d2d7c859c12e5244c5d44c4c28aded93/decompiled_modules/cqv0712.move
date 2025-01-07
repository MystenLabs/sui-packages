module 0xe3030b06c4abd1bfb9abc78256b30873d2d7c859c12e5244c5d44c4c28aded93::cqv0712 {
    struct CQV0712 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CQV0712, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CQV0712>(arg0, 9, b"CQV0712", b"RachSui", b"No scam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/59049bf4-589e-4e76-a143-55fad7d03eb1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CQV0712>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CQV0712>>(v1);
    }

    // decompiled from Move bytecode v6
}

