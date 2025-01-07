module 0x8bbf7dc6873849bde974ff42ed5840321f9591726591ea972365f8000398b790::arf {
    struct ARF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARF>(arg0, 9, b"ARF", b"Dog in a cats world", b"Dog in a cats world on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARF>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARF>>(v1);
    }

    // decompiled from Move bytecode v6
}

