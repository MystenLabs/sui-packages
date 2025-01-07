module 0x6ef7ecaf16ab9f2b5c65c631d15a48da9f55cfb45b98e4c647c149b1e0ad93eb::ted {
    struct TED has drop {
        dummy_field: bool,
    }

    fun init(arg0: TED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TED>(arg0, 6, b"TED", b"TED SUI", b"$TED - The foul-mouthed yet endearing teddy bear", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_11_07_27_50_64a5c9c0a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TED>>(v1);
    }

    // decompiled from Move bytecode v6
}

