module 0x54dc33646ae1a8219df37ba8f1cebe0df35527c3908fb80937b0bce78bb2e75e::kl {
    struct KL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KL>(arg0, 9, b"KL", b"Ka lua", b"KA LUA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46c6c1ab-93fb-4f3f-9733-39ca215ac45b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KL>>(v1);
    }

    // decompiled from Move bytecode v6
}

