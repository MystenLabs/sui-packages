module 0xae31ed260a42c1328dcafc19f11c95ca89c8c4cbbf4b642827c1d09f4e54d19f::nnu {
    struct NNU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNU>(arg0, 9, b"NNU", b"Nunu", b"Nunung", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6839cbe-63bf-4d2a-8a23-0a03edbb1d55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNU>>(v1);
    }

    // decompiled from Move bytecode v6
}

