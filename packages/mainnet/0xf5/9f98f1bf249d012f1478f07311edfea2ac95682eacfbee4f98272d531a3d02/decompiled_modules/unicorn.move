module 0xf59f98f1bf249d012f1478f07311edfea2ac95682eacfbee4f98272d531a3d02::unicorn {
    struct UNICORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNICORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNICORN>(arg0, 6, b"Unicorn", b"Davi unicorn", b"Davi the unicorn will change meta in sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigvqg3dk4tyemkeecicqko3bolx3fylu5y6t2rqcm734f7qvfe6sy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNICORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UNICORN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

