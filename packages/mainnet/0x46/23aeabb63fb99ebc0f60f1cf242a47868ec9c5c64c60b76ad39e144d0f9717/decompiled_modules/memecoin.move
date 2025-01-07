module 0x4623aeabb63fb99ebc0f60f1cf242a47868ec9c5c64c60b76ad39e144d0f9717::memecoin {
    struct MEMECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECOIN>(arg0, 9, b"MEMECOIN", b"MEMECOIN", b"Memecoin Supercycle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmYyKagNe4M7iP1NqmvU8E6Tow8DaNKx3Asphk4AE1dpJ1"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEMECOIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMECOIN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEMECOIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

