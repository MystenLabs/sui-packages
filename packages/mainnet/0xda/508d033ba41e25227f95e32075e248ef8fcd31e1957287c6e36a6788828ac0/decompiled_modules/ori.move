module 0xda508d033ba41e25227f95e32075e248ef8fcd31e1957287c6e36a6788828ac0::ori {
    struct ORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORI>(arg0, 6, b"ORI", b"ORI THE FISH", x"48692c2049e280996d20456c6f6e204d75736be28099732070657420666973682c20457269632e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731600029191.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

