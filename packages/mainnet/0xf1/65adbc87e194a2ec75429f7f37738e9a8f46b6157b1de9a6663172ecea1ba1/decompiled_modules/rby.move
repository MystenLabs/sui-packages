module 0xf165adbc87e194a2ec75429f7f37738e9a8f46b6157b1de9a6663172ecea1ba1::rby {
    struct RBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBY>(arg0, 9, b"RBY", b"ruby token", b"baby ruby token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0591be09-125a-4bdc-8a1c-eb81d30cb7b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

