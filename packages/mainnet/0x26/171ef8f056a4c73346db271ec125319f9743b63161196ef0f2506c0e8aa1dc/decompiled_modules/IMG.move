module 0x26171ef8f056a4c73346db271ec125319f9743b63161196ef0f2506c0e8aa1dc::IMG {
    struct IMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = mint(arg0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IMG>>(v0);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IMG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: IMG, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<IMG>, 0x2::coin::CoinMetadata<IMG>) {
        let (v0, v1) = 0x2::coin::create_currency<IMG>(arg0, 9, b"SUIMON", b"SUIMON", x"5355494d4f4e206973207468652066697273742067616d696669656420506f6bc3a96d6f6e2d7374796c6520746f6b656e206f6e20535549e28094616e64206974e2809973206275696c7420646966666572656e742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blue-historic-hookworm-762.mypinata.cloud/ipfs/bafybeigtu2nl3mx6hlsa766hoaofgmo2zwbwjuua2kcfjdajzfmlewkgfy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IMG>(&mut v2, 1000000000000000000, @0x95463db0ca7dfe2db1c5bb911be6c5a67e49f27b842ec2f0c0ca2b2a36ce0ba7, arg1);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

