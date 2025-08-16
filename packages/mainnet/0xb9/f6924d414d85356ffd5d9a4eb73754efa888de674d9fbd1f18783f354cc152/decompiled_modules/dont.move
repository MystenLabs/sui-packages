module 0xb9f6924d414d85356ffd5d9a4eb73754efa888de674d9fbd1f18783f354cc152::dont {
    struct DONT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONT>(arg0, 9, b"DONT", b"DONT", b"Don't buy this coin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DONT>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONT>>(v2, @0xd6eb850fdab4143fa973ab119a1b27d5db8744cb8ef7a88125fd33a6ab85b351);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONT>>(v1);
    }

    // decompiled from Move bytecode v6
}

