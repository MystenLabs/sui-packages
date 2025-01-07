module 0xf9ff0048cf2a1bc13bccb90635a5174236eb9025a87999eb07e7da0cd2223f81::sh {
    struct SH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SH>(arg0, 9, b"SH", b"sui hacker", b"shsh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.oaiusercontent.com/file-SBFP8aVYWHkgCVMtJf9RWPsA?se=2024-04-27T06%3A03%3A44Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D6149d989-6388-47f6-b2b3-a0cfc8b6971b.webp&sig=geI4TPnx5Pq9t3uvh5EJXvlF4uY1X%2BbvujBIan/Wlc4%3D")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SH>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SH>>(v1);
    }

    // decompiled from Move bytecode v6
}

