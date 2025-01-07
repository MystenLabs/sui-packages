module 0x334f09a1b573f98dc547beb1a79c5a0b6fb577044b9ae6df38fbf434abb780d7::shaaark {
    struct SHAAARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAAARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAAARK>(arg0, 6, b"SHAAARK", b"Shaaark", b"I'm just a shark. Let's all get together as filthy degens and help me rise to the surface of the Sui waters to become the #1 shark on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Preview_5_53bd656bd5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAAARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAAARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

