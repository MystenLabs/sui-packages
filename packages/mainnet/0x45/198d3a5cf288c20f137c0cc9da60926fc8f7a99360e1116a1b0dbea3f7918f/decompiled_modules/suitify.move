module 0x45198d3a5cf288c20f137c0cc9da60926fc8f7a99360e1116a1b0dbea3f7918f::suitify {
    struct SUITIFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITIFY>(arg0, 6, b"Suitify", b"Suitify Coin", x"5375697469667920697320612063757474696e672d656467652063727970746f63757272656e63792064657369676e6564207370656369666963616c6c7920666f7220746865206d7573696320696e6475737472792e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suitify_Coin_c22156d06d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITIFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITIFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

