module 0xb8222dacfe07871bf4fb2dd4a67148e4c13fb45b9c66ff940f4ea58208f5ffa2::apec {
    struct APEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEC>(arg0, 6, b"APEC", b"Ape Apocalypse", b"APEC memecoin build on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1755360455202.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APEC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

