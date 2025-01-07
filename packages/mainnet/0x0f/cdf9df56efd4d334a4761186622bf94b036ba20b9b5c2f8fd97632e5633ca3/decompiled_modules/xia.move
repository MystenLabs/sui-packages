module 0xfcdf9df56efd4d334a4761186622bf94b036ba20b9b5c2f8fd97632e5633ca3::xia {
    struct XIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIA>(arg0, 6, b"Xia", b"TTxia", b"Shrimp are fascinating marine creatures, small in appearance yet full of energy. Their bodies are semi-transparent, covered with a hard shell, like a natural suit of armor, but they are quick and lively inside. Shrimp can even emit a faint glow at night, twinkling in the dark waters like the stars of the ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_157_de3bd78c9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

