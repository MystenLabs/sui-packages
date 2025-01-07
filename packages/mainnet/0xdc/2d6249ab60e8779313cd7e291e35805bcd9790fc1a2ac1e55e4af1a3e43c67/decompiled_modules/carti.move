module 0xdc2d6249ab60e8779313cd7e291e35805bcd9790fc1a2ac1e55e4af1a3e43c67::carti {
    struct CARTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARTI>(arg0, 9, b"CARTI", b"PLAYBOI CARTI", b"WHAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.scdn.co/image/ab67616100005174b3d8cd43a716a031fe7e1ab6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CARTI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARTI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

