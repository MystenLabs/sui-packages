module 0xd165ca73be5211d35e0d52d4cc65ffd4b2861d37934d5ba2df551e67f8549976::thc {
    struct THC has drop {
        dummy_field: bool,
    }

    fun init(arg0: THC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THC>(arg0, 6, b"THC", b"TETRAHIDROCANNABINOL", b"$THC is the ultimate token for cannabis enthusiasts and the Sui community. Freedom should always be part of the trip.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib57fg6z7ozkihqqezj4nxf5fa2m3kl7nv7ux2fmndy3mf5dw4dcm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<THC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

