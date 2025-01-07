module 0xdbbee51257c3e0ae726aee1de20cda29904a5d25fe2504319ae5805e6717f4ab::suitempleton {
    struct SUITEMPLETON has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"FTI", b"SUITEMPLETON", b"Launched alongside the groundbreaking news: Sui Foundation enters a strategic partnership with Franklin Templeton Digital Assets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GdAHc8zWsAEQc6H?format=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SUITEMPLETON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SUITEMPLETON>(arg0, arg1);
        0x2::coin::mint_and_transfer<SUITEMPLETON>(&mut v0, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEMPLETON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

