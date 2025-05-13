module 0x32c3f7cf87be642a9b49649cd6b10c64dd8b0c1372a8cd1e46d68549799e0bb3::avds {
    struct AVDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVDS>(arg0, 6, b"AVDS", b"Test abc", b"hello shop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaaanx6zk2ms53kiwrrwyy2re53zjz46rwlwuv2pyc5bmewx4p5fq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AVDS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

