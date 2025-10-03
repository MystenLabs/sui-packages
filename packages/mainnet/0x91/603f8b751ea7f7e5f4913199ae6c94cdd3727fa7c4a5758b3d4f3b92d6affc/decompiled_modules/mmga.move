module 0x91603f8b751ea7f7e5f4913199ae6c94cdd3727fa7c4a5758b3d4f3b92d6affc::mmga {
    struct MMGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMGA>(arg0, 6, b"MMGA", b"Make Moonbags Great Again", b"It's time to bring that era back. $MMGA is our rallying cry to restore Moonbags's power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiebehl6o67leqr5coafdc73lldqekiw4aec43kjfjbim2hkz52jka")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MMGA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

