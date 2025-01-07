module 0xf1add2d056387167a307847c7b771e8f34bd16a9da376172a25b8adab6a53675::xiao {
    struct XIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIAO>(arg0, 6, b"XIAO", b"XIAO PANG SUI", b"Xiao Pang is a popular dog from China, known for his chubby appearance and expressive face. His adorable, round features and playful personality made him a social media sensation, capturing hearts with his cute, almost human-like expressions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_1_9c144ea1cf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

