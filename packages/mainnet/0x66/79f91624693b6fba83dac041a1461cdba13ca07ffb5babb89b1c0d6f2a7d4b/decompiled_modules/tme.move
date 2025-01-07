module 0x6679f91624693b6fba83dac041a1461cdba13ca07ffb5babb89b1c0d6f2a7d4b::tme {
    struct TME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TME>(arg0, 9, b"TME", b"time", b"Tick into the future with TimeCoin: The crypto that's all about seizing the moment, delivering timely profits and clockwork precision in every transaction!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d812c02-9b36-4f2f-8222-77696f4717dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TME>>(v1);
    }

    // decompiled from Move bytecode v6
}

