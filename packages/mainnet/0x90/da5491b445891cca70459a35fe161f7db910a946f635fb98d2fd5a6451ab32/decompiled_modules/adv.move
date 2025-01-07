module 0x90da5491b445891cca70459a35fe161f7db910a946f635fb98d2fd5a6451ab32::adv {
    struct ADV has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADV>(arg0, 9, b"ADV", b"aduvup", b"ABCA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/787103a9-3466-4499-9b60-a6cbac2cafc4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADV>>(v1);
    }

    // decompiled from Move bytecode v6
}

