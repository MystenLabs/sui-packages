module 0x98f7130e17e6e5a298173cd57e3e2901729e2326602819504eccadaae62eb6c::insider {
    struct INSIDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSIDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSIDER>(arg0, 6, b"Insider", b"Insiders DAO", b"The sharpest group in Web3. Ran by @kropts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/photo_2024_09_25_01_40_15_22a0e0fa98.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSIDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INSIDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

