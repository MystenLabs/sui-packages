module 0x26ba3c7e0f0ead7ca38b826fd58f8d80533e548dc2bee08e2fccf2f4a96eac5f::suifu {
    struct SUIFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFU>(arg0, 6, b"SUIFU", b"Suifu coin", x"2220537569667520636f696e2069732070726f6f662074686174206d656d6573206861766520706f7765722e20546f6765746865722c2077652063616e2063726561746520736f6d657468696e67207472756c79207370656369616c2e220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Clipped_image_20241012_090317_c60fbf6ca5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

