module 0x888928248b9060b9d6b16a6ff3528704769b8195209ec22a6cf291534a9c7f58::vno846 {
    struct VNO846 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<VNO846>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VNO846>>(0x2::coin::mint<VNO846>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: VNO846, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VNO846>(arg0, 9, b"VNO846", b"VINO Debit", x"56494e4f20446562697420746f6b656e20e28094204669626f6e6163636920737570706c793a2031303934362e20496e737572616e63653a203130306270732e2058616861753a20724a3268564d396d725136355265594774796e674761525a45714851343944366566", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://zedec.io/tokens/vno846.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VNO846>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VNO846>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

