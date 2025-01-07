module 0x978af837c5a71931539dcbaa8d9a0be8175e7f6c3caca78b53f1c5dd93a3b59b::gpg {
    struct GPG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPG>(arg0, 9, b"GPG", b"GGG", b"kogda tge???", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/754316f0-9ea5-44c1-ac7d-cf5337249356.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GPG>>(v1);
    }

    // decompiled from Move bytecode v6
}

