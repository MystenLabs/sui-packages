module 0x2fd0603b94e26d704c08985495ede2d5de1e87263c5b5322a2f8cb54ac79678e::hdmi {
    struct HDMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDMI>(arg0, 6, b"HDMI", b"HOLY DRUNK MIDGET", b"HOLY DRUNK MIDGET IS NOW ON SUI SAME DEV AS HDMI ON SOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1727_55f489d1fa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HDMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

