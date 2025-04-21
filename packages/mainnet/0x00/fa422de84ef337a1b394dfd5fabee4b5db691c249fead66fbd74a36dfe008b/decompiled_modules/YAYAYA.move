module 0xfa422de84ef337a1b394dfd5fabee4b5db691c249fead66fbd74a36dfe008b::YAYAYA {
    struct YAYAYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAYAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAYAYA>(arg0, 6, b"YAYAYA", b"raise your ya ya ya", b"RAISE YOUR YA YA YA!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmbrsefAJ48a1SitZcycwVricGssM9c5LrjkPNN57MgQKv")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAYAYA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAYAYA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

