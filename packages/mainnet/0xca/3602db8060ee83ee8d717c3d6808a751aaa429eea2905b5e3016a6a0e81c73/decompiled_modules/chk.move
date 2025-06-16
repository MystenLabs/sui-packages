module 0xca3602db8060ee83ee8d717c3d6808a751aaa429eea2905b5e3016a6a0e81c73::chk {
    struct CHK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHK>(arg0, 6, b"CHK", b"Check", b"checking token structure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifnc3t7iptcqzhlqh66zql3rxi46xcmfv4ur3yoyq26fl6s67u3a4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

