module 0x205ded648b14dbdfcfea5964034078f26f0db1d3d552e88c78bc2e74262fe1d0::pet {
    struct PET has drop {
        dummy_field: bool,
    }

    fun init(arg0: PET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PET>(arg0, 9, b"PET", b"Pug smile", b"Mypet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd87ace5-2705-4439-ad54-418d8dc5cf0b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PET>>(v1);
    }

    // decompiled from Move bytecode v6
}

