module 0xb4945ddb244761aaca34fd9792529d242b2988b6ee67140ff7383326b7dda1e5::soc {
    struct SOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOC>(arg0, 6, b"SOC", b"Sui octopus candle", b"Let's light up the sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_17_42_19_ced5488f21.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

