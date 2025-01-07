module 0xfa21790b4084a2fb6dfdf55f2ed6b764af7f1dd252143869777ec2f32b143e55::walrus20 {
    struct WALRUS20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALRUS20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALRUS20>(arg0, 9, b"WALRUS20", b"Hab33bulla", b"Awesome walrus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/154e0dff-8595-4f88-93f3-5c124b0ecf69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALRUS20>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALRUS20>>(v1);
    }

    // decompiled from Move bytecode v6
}

