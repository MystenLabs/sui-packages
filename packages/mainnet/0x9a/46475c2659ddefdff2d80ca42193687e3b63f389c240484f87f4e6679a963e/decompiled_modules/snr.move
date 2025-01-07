module 0x9a46475c2659ddefdff2d80ca42193687e3b63f389c240484f87f4e6679a963e::snr {
    struct SNR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNR>(arg0, 6, b"SNR", b"SUINARDO", b"Cristiano Ronaldos iconic Siuuu celebration has become a global phenomenon. The celebration involves Ronaldo jumping, spinning in mid-air, and shouting Siuuu, which close to SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUINARDO_6ddc627eb5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNR>>(v1);
    }

    // decompiled from Move bytecode v6
}

