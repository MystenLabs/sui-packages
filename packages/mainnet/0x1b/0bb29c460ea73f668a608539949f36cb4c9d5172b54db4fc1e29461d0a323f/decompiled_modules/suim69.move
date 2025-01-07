module 0x1b0bb29c460ea73f668a608539949f36cb4c9d5172b54db4fc1e29461d0a323f::suim69 {
    struct SUIM69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIM69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIM69>(arg0, 6, b"SUIM69", b"SUI ROOM", b"Leverages the power of artificial intelligence with AI ROOM by AI Room Foundation. To ensure top-notch security for every transaction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_24_06_50_49_eb1eefe069.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIM69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIM69>>(v1);
    }

    // decompiled from Move bytecode v6
}

