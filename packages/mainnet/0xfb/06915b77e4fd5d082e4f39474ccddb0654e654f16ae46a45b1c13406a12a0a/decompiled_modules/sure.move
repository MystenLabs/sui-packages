module 0xfb06915b77e4fd5d082e4f39474ccddb0654e654f16ae46a45b1c13406a12a0a::sure {
    struct SURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURE>(arg0, 6, b"SURE", b"Sui Resistance", b"Sui Resistance is set to become the leading meme project within the Sui ecosystem, standing tall in a market dominated by short-term hype and pump-and-dump trends. Positioned as the front-runner in this new era", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pt_Makqu_Q_400x400_f3220fffd5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURE>>(v1);
    }

    // decompiled from Move bytecode v6
}

