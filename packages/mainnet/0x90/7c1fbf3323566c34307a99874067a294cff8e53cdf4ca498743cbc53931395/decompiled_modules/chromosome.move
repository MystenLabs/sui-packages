module 0x907c1fbf3323566c34307a99874067a294cff8e53cdf4ca498743cbc53931395::chromosome {
    struct CHROMOSOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHROMOSOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHROMOSOME>(arg0, 6, b"CHROMOSOME", b"Chromosome", b"From double helix to double gains. Join the $XX revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1735945862078_12245a3157.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHROMOSOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHROMOSOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

