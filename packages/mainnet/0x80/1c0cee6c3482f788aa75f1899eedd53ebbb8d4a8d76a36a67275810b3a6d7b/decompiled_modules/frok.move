module 0x801c0cee6c3482f788aa75f1899eedd53ebbb8d4a8d76a36a67275810b3a6d7b::frok {
    struct FROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROK>(arg0, 9, b"FROK", b"frok", b"buy frok and you will never be brok. x.com/froksui t.me/frokonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/rbeIfN0.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FROK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

