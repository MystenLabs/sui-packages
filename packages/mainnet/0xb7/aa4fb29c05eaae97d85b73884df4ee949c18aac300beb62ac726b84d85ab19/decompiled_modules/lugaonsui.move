module 0xb7aa4fb29c05eaae97d85b73884df4ee949c18aac300beb62ac726b84d85ab19::lugaonsui {
    struct LUGAONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUGAONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUGAONSUI>(arg0, 6, b"LugaonSui", b"Beluga", b"Dolphin of Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5625_0ae75036eb_1e1b202d83.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUGAONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUGAONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

