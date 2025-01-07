module 0x9cabc406b46c32a4b74349e2de5b9d6d8665ac52bb993c11458cc29c83a0ff2b::suiinu {
    struct SUIINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIINU>(arg0, 9, b"suiinu", b"Sui Inu", b"Sui Inu is Sui's ecosystem mascot dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/users/1731254/avatars/normal/76437b08ae5a562ef735b6f2fd03db97.png?1495002920")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIINU>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIINU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

