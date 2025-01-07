module 0x1b9042dd8c7ad47c72a5e81ea6a2e9e0fdd5ac108ca6a8a0efb55edee3e59de::hedgy {
    struct HEDGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEDGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEDGY>(arg0, 6, b"HEDGY", b"Hedgy Sui", b"$HEDGY: A non-meme that has a reason! The first and only animal rescue token on the sui network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016247_b048967770.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEDGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEDGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

