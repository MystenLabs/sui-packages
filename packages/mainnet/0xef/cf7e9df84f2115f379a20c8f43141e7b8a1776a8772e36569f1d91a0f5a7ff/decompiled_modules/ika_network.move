module 0xefcf7e9df84f2115f379a20c8f43141e7b8a1776a8772e36569f1d91a0f5a7ff::ika_network {
    struct IKA_NETWORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKA_NETWORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKA_NETWORK>(arg0, 6, b"IKA NETWORK", b"ika", x"546865206661737465737420706172616c6c656c204d5043206e6574776f726b2c206c61756e6368696e67206f6e200a405375694e6574776f726b2028707265762e206457616c6c6574204e6574776f726b29", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihrix4yluobjtbl4w4wegw5b6jnm3nenm5dpv5ibf3cozqoan3lnu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKA_NETWORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IKA_NETWORK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

