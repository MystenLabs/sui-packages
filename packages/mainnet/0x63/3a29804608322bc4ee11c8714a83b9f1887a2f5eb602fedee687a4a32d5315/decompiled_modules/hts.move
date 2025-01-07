module 0x633a29804608322bc4ee11c8714a83b9f1887a2f5eb602fedee687a4a32d5315::hts {
    struct HTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTS>(arg0, 9, b"HTS", b"Hot Girs", b"Hot girs token meme wave ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5435588-96fe-4550-baa2-c4a1524e6343.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

