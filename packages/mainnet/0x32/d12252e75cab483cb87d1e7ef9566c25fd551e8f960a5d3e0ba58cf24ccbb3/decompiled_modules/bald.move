module 0x32d12252e75cab483cb87d1e7ef9566c25fd551e8f960a5d3e0ba58cf24ccbb3::bald {
    struct BALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALD>(arg0, 9, b"BALD", b"Bald token", b"For all the bald daddies, we deserve better", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3cb1c231-6e48-44f2-92fb-87be3086f16c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

