module 0xac335ee8bfd0647c58d1dc868e8f6de964a0aa0d902748c80dea40f22772a24f::dogfake {
    struct DOGFAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGFAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGFAKE>(arg0, 6, b"DogFake", b"DogFake Token", b"Fake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGFAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGFAKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

