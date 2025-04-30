module 0x97f7fc768bd6aa91288e0898b3e82b9163ad88c0daf36618fca7968a37ce363a::babybit {
    struct BABYBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYBIT>(arg0, 6, b"Babybit", b"BabyBitcoin", b"Babybitcoin on SUi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_2b05608414.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

