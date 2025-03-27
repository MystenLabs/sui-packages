module 0x715877564708b5ed51879e330309a926936dabb015b1c1a96b11f28c96c51e8b::bwal {
    struct BWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWAL>(arg0, 9, b"BWAL", b"baby walrus", b"Welcome to the next generation of memes. The most secure, efficient, and cute baby Walrus ever to launch on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Fphoto_2025_03_27_01_26_00_dbfd820419.jpg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BWAL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWAL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

