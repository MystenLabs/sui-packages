module 0x355a7062602913840b3d67d4a3d59626913c477d9901771db188901dfaa3edfb::rspc {
    struct RSPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSPC>(arg0, 9, b"RSPC", b"Ridley", b"Ridley Stinky Poopy Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wixstatic.com/media/c11564_69de82fa39a54df889601fa0f26237a3~mv2.jpg/v1/fill/w_250,h_250,al_c,q_80,enc_auto/c11564_69de82fa39a54df889601fa0f26237a3~mv2.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RSPC>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSPC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RSPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

