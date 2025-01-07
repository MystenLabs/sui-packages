module 0x401f62548fe4c4d69fda2e31313ba62f9b8c8dcbb5e942da0223507b00b7f943::vb {
    struct VB has drop {
        dummy_field: bool,
    }

    fun init(arg0: VB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VB>(arg0, 9, b"VB", b"Viral Base", b"Introducing Viral Base (VB), a cutting-edge cryptocurrency designed to enhance community engagement and drive viral growth. With fast transactions and top-notch security, VB empowers users to connect and thrive. Join us and be part of the financial.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5f18d8f-26ce-4b2e-849b-23b7bd62e66c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VB>>(v1);
    }

    // decompiled from Move bytecode v6
}

