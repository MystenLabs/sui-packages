module 0xa986ab4b33c8799c39554cdff914c5fef47b3a2982ce0320be1dc32cdf4bdde::wwgl {
    struct WWGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWGL>(arg0, 9, b"WWGL", b"WeWeGombeL", b"WeWeGombeL is another of meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6fe5451-e370-4a20-93e9-9fd9811a3dc1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

