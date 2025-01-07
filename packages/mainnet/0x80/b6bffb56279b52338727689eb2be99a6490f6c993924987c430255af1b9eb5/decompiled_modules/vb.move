module 0x80b6bffb56279b52338727689eb2be99a6490f6c993924987c430255af1b9eb5::vb {
    struct VB has drop {
        dummy_field: bool,
    }

    fun init(arg0: VB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VB>(arg0, 9, b"VB", b"Viral Base", b"Introducing Viral Base (VB), a cutting-edge cryptocurrency designed to enhance community engagement and drive viral growth. With fast transactions and top-notch security, VB empowers users to connect and thrive. Join us and be part of the financial.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/70089b10-f5d3-4e3c-abcb-b8a157bf5e5a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VB>>(v1);
    }

    // decompiled from Move bytecode v6
}

