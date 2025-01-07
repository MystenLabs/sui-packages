module 0x9f3778d8354d98074f0ca8e13a9623ccad7535722af2fddf0653896d103b4c27::auction {
    struct AUCTION has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUCTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUCTION>(arg0, 9, b"AUCTION", b"Banana", b"a yellow banana duct-taped to a white wall exactly 160 centimeters (63 inches) above the ground", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4ee094d-609a-4cae-ab9e-6fdca63be78d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUCTION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUCTION>>(v1);
    }

    // decompiled from Move bytecode v6
}

