module 0x9ffa92706539553f16599070fb47527ceef9c44a87f5a5e1cd2529ddc2b859fd::lie5 {
    struct LIE5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIE5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIE5>(arg0, 6, b"LIE5", b"LIE$", b"LIFE IS EXPENSIVE,THE 5 IS SERIOUSLY A S,FILL YOUR POCKETS WITH LIE5 ITS DANGEROUS OUT THERE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_1_a6c6d95ec7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIE5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIE5>>(v1);
    }

    // decompiled from Move bytecode v6
}

