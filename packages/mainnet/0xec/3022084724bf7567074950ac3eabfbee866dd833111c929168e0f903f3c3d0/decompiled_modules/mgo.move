module 0xec3022084724bf7567074950ac3eabfbee866dd833111c929168e0f903f3c3d0::mgo {
    struct MGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGO>(arg0, 8, b"MGO", b"Mango Network", b"Multi-VM Omni-Chain Infra Network | Integrates the core advantages of OPStack & #Move | EVM & MoveVM support", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/9bd94827-f706-4be8-866e-b2eda0d6b94b.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MGO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

