module 0xe42f939cefbf69a322d8364f8dc46899965e3b052c50a05703c010020ad318d2::woo_wewe {
    struct WOO_WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOO_WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOO_WEWE>(arg0, 9, b"WOO_WEWE", b"Woowewe", b"Woo-woo......", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f0c776c-3359-4dcf-a762-bdc3d33fd75a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOO_WEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOO_WEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

