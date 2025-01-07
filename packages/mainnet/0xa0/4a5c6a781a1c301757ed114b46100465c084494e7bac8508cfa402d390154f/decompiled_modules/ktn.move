module 0xa04a5c6a781a1c301757ed114b46100465c084494e7bac8508cfa402d390154f::ktn {
    struct KTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KTN>(arg0, 9, b"KTN", b"Katunya ", b"Katunya the world love token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b6d53982-3b92-4bcb-b138-8e07cb6bd8b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

