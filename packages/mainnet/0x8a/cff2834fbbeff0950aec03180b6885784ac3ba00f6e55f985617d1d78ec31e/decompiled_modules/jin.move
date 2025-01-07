module 0x8acff2834fbbeff0950aec03180b6885784ac3ba00f6e55f985617d1d78ec31e::jin {
    struct JIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIN>(arg0, 6, b"JIN", b"SUI JIN", b"The most handsome puppy in Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kakao_Talk_20241002_212331497_e7fff9b58c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

