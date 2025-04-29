module 0x8f96a479a7595c39ebb1eaf02fdead89ac7c2cf8b7f64f366b1cd24ff9c5a74c::puggy {
    struct PUGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGGY>(arg0, 6, b"PUGGY", b"PUGGYDOG", x"5055474759444f4720697320746865206d6f737420636f6f6c65737420616e64206472697070696e272064617767206f6e0a5375692e205745204152452046414d494c592c20574520415245205355492c2057452041524520505547475921200a5745205249444520544f20544845204d4f4f4e21200a5055474759204c464721200a505547475920436f6d6d756e69747920666f722053554921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifamuzbeus5mubcjd7erll4meqkgwe6nxorqmoeq67co25czj3g4y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUGGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

