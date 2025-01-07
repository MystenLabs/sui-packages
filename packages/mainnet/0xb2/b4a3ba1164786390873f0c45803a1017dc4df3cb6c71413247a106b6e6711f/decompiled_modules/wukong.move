module 0xb2b4a3ba1164786390873f0c45803a1017dc4df3cb6c71413247a106b6e6711f::wukong {
    struct WUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUKONG>(arg0, 6, b"WUKONG", b"Sui Wukong", b"In the bustling metropolis of Sui City, a new legend was born. A mischievous monkey, imbued with the spirit of the legendary Monkey King, emerged from the digital realm. This was SUI WUKONG, a creature of code and community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_16_31_13_86041dde8f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

