module 0x94e303fe4693e4492925a8368da3e095b989bfeada75ee5d00a66730efb64d46::suigull {
    struct SUIGULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGULL>(arg0, 6, b"SUIGULL", b"Suigull", b"Cool suigull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.oaiusercontent.com/file-dgnzJwlCsMOPFBATq2kMvspk?se=2023-12-20T08%3A34%3A01Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3Dae087cb2-c881-4cf8-91b2-1046c39c3736.webp&sig=z/V0Kt%2BniuFgrmxas5eTLVJOtFRfoxb6KbPVfvPDoOU%3D")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGULL>(&mut v2, 4206942070000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGULL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

