module 0x6c50d9f7e4e306668d1156d7a5d19fd44f18e3d2ae7eddfdbde64211d0f59f8b::catshark {
    struct CATSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSHARK>(arg0, 9, b"CATSHARK", b"Cat Shark", b"It's not just any animal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmWKP6HqK1XPzQ67SwfN8k8oZYJQ8ikpArythymT3wBmL8?img-width=800&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATSHARK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSHARK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

