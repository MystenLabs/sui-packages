module 0x12cfe41db7e5a0e290a6a3864aba5bd036a18ed9167c49ded1bbc7da4a89d7f8::ghg {
    struct GHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHG>(arg0, 9, b"ghgghg", b"ghg", b"ghgghgghgghg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

