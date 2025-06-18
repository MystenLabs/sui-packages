module 0x48ac5e79695c1a74345b8ae4db9cb5312174219a01e787e9bdf82b8841fb1f8f::gate {
    struct GATE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GATE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GATE>>(0x2::coin::mint<GATE>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    fun init(arg0: GATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATE>(arg0, 9, b"GATE", b"Gated", b"adsf asdfsafadsfsad fdsf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://127.0.0.1:54321/storage/v1/object/public/drop-images/0eaf2f29-e059-472d-95f4-28191c83d5f0.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<GATE>>(0x2::coin::mint<GATE>(&mut v2, 1 * 1000000000 / 100 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GATE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

