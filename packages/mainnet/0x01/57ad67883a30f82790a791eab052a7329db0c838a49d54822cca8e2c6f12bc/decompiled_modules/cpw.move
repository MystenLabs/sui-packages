module 0x157ad67883a30f82790a791eab052a7329db0c838a49d54822cca8e2c6f12bc::cpw {
    struct CPW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPW>(arg0, 9, b"CPW", b"cat's paw", b"cute and strong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd23971a-00af-4e25-97e9-11a782f76de5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CPW>>(v1);
    }

    // decompiled from Move bytecode v6
}

