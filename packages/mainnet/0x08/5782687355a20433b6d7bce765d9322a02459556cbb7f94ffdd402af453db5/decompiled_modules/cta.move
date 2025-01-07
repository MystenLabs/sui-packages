module 0x85782687355a20433b6d7bce765d9322a02459556cbb7f94ffdd402af453db5::cta {
    struct CTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTA>(arg0, 9, b"CTA", b"Catto", b"Transaction purposes ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9785d554-c7ad-40d5-aa8a-e4b44e81afe8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

