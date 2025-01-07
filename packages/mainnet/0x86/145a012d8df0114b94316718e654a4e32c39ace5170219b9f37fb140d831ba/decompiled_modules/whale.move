module 0x86145a012d8df0114b94316718e654a4e32c39ace5170219b9f37fb140d831ba::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"Whale", b"Chill Whale ON SUI", b"$WHALE where power meets limitless opportunity!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CZ_7imi_E_400x400_6484bff03a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

