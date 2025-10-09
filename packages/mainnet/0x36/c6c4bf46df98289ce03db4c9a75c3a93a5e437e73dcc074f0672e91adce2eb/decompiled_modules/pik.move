module 0x36c6c4bf46df98289ce03db4c9a75c3a93a5e437e73dcc074f0672e91adce2eb::pik {
    struct PIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIK>(arg0, 9, b"PIK", b"pikachu", b"Pikachu official mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIK>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIK>>(v2, @0xf110f0f47d28d782fb4f2fae7d5f949466a1d27754b6e9b38e0e0ccb266ca213);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

