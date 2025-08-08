module 0x716a42ee8a4407319a6afcad727b4694dc16b963ce36d7e97896b52628ab105::ftc {
    struct FTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTC>(arg0, 6, b"FTC", b"For The Community", b"this probably goes to zero, but who knows.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihsllopjbpydj4sixyruholbpfxgbpg62wsoeooo5i6k3duglejwa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

