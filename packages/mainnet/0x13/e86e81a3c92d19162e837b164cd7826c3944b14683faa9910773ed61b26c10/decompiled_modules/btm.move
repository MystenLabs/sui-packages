module 0x13e86e81a3c92d19162e837b164cd7826c3944b14683faa9910773ed61b26c10::btm {
    struct BTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTM>(arg0, 6, b"BTM", b"Big tit mermaid", b"The best of the ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000044631_567f7327f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

