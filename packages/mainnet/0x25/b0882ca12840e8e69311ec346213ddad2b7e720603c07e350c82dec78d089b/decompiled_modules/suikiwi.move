module 0x25b0882ca12840e8e69311ec346213ddad2b7e720603c07e350c82dec78d089b::suikiwi {
    struct SUIKIWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKIWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKIWI>(arg0, 6, b"SUIKIWI", b"KIWI ON SUI", x"546865206b6977692062697264206a7573742077616e747320746f20666c790a77696c6c20796f75206a6f696e2068696d206f6e2074686973206a6f75726e657920746f20666c793f20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_06_224039_7a32da8a47.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKIWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKIWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

