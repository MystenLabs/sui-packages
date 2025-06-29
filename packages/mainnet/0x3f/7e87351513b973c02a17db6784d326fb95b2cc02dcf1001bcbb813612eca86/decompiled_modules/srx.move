module 0x3f7e87351513b973c02a17db6784d326fb95b2cc02dcf1001bcbb813612eca86::srx {
    struct SRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRX>(arg0, 8, b"SRX", b"StorX", b"Join our #DePIN revolution: Store and access your data safely with our decentralized cloud. Host a node to earn $SRX or pay $SRX for secure storage.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/bf1e549d-e154-4126-815d-4fbc88573b38.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SRX>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRX>>(v1);
    }

    // decompiled from Move bytecode v6
}

