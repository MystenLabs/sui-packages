module 0x853a2e435ba2611bfd1aa66f0935a56c78e9fd6ab82842d809ed5570d8c7f6d6::suiset {
    struct SUISET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISET>(arg0, 6, b"SUISET", b"SUISET.FUN", b"The sun may set, but SuiSetFun rises! Ride the golden glow of crypto's most radiant meme coin, where every transaction feels like a sunset beach party. Who needs moonshots when you can bask in the warmth of SuiSetFun?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6179281092591338540_117c2cbf26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISET>>(v1);
    }

    // decompiled from Move bytecode v6
}

