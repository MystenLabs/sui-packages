module 0x60258999a75f69f31ea4ed3158b6e5af4eb094e12fbf507aca902554a871b7c2::fakeg {
    struct FAKEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKEG>(arg0, 6, b"FakeG", b"DOGFake", b"Dontbuy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FAKEG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

