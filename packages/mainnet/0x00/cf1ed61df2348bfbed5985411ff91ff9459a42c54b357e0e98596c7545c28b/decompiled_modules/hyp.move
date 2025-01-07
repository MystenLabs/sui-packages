module 0xcf1ed61df2348bfbed5985411ff91ff9459a42c54b357e0e98596c7545c28b::hyp {
    struct HYP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYP>(arg0, 9, b"HYP", b"Hyper", b"For the Hype Squad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1db5eef4-9afb-44aa-9063-7cf002247150.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYP>>(v1);
    }

    // decompiled from Move bytecode v6
}

