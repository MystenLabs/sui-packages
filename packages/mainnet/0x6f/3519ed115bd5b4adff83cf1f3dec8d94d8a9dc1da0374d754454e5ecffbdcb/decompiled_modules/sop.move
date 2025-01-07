module 0x6f3519ed115bd5b4adff83cf1f3dec8d94d8a9dc1da0374d754454e5ecffbdcb::sop {
    struct SOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOP>(arg0, 9, b"SOP", b"Sui Overflow Participant", b"Sui Overflow Participant!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/QdUOQBp.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOP>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOP>>(v2, @0x96d9a120058197fce04afcffa264f2f46747881ba78a91beb38f103c60e315ae);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

