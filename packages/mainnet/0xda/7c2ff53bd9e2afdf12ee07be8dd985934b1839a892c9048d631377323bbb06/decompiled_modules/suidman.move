module 0xda7c2ff53bd9e2afdf12ee07be8dd985934b1839a892c9048d631377323bbb06::suidman {
    struct SUIDMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDMAN>(arg0, 6, b"SUIDMAN", b"SUIDERMAN", x"5065746572205065726b6572206173206175746973746963207370696465726d616e2069732068697474696e672073756920636861696e2e20486520737469636b7320746f20746865206d61726b657420616e64206e65766572206c657474696e6720697420676f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736704169264.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

