module 0x3269f13d571a9a8583eda4fa08bf7c5de34f78ea3d8ec2f02a5187dbbd5bdfa2::stb {
    struct STB has drop {
        dummy_field: bool,
    }

    fun init(arg0: STB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STB>(arg0, 6, b"STB", b"SUMU THE BULL", b"Meet $SUMU, the meme bull on the Sui chain! Hes here to bring the bullish energy and good vibes to the blockchain world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sumu_bfd59a2ea1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STB>>(v1);
    }

    // decompiled from Move bytecode v6
}

