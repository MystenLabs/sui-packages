module 0xe77d0b506057ed51eb07fcae2d5ade723a2cc29ae6e31baa71d092f73543fad0::foxsuicto {
    struct FOXSUICTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXSUICTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXSUICTO>(arg0, 6, b"FOXSUICTO", b"SuiFoxCTO", x"7465616d20617265206661726d696e6720736f2069766520637265617465642074686973206f6e6520666f7220796f7520616c6c0a0a7765622077697468207574696c6974790a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_11_04_13_10_53_cd7ddc988e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXSUICTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOXSUICTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

