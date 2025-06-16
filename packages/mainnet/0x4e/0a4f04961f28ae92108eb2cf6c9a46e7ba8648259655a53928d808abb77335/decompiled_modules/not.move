module 0x4e0a4f04961f28ae92108eb2cf6c9a46e7ba8648259655a53928d808abb77335::not {
    struct NOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOT>(arg0, 6, b"NOT", b"nothing", b"nothing but Walrus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_05_17_094927_102f182117.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

