module 0xb256e18dab0ac5234894f24ac603da55025f44f9035b82b6c71e11aa55561db3::karbid {
    struct KARBID has drop {
        dummy_field: bool,
    }

    fun init(arg0: KARBID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KARBID>(arg0, 9, b"KARBID", b"Karb", x"4f6e6c79207374726f6e672c206f6e6c79206265747465722c206f6e6c792066756e2c206f6e6c79206861726420f09f9880", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1757aa02-415a-4866-943e-ef44056f5ef4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KARBID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KARBID>>(v1);
    }

    // decompiled from Move bytecode v6
}

