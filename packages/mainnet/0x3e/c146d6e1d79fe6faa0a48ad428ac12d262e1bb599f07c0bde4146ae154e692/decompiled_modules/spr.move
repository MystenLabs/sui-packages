module 0x3ec146d6e1d79fe6faa0a48ad428ac12d262e1bb599f07c0bde4146ae154e692::spr {
    struct SPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPR>(arg0, 9, b"SPR", b" SPORE", x"d09cd0b5d0bc20d182d0bed0bad0b5d0bd20d181d0bfd0bed180d18b2c20d180d0b0d181d0bfd180d0bed181d182d180d0b0d0bdd0b8d0bc20d181d0bfd0bed180d18b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53aa8775-d5e8-44cd-beb3-6aaf7c55c9ef-1000035729.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

