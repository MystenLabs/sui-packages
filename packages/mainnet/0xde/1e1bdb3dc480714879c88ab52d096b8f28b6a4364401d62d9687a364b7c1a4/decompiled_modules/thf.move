module 0xde1e1bdb3dc480714879c88ab52d096b8f28b6a4364401d62d9687a364b7c1a4::thf {
    struct THF has drop {
        dummy_field: bool,
    }

    fun init(arg0: THF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THF>(arg0, 9, b"THF", b"Techiehome", b"Nothing Else", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b14ca86-e390-4733-bf63-dadaaba5787a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THF>>(v1);
    }

    // decompiled from Move bytecode v6
}

