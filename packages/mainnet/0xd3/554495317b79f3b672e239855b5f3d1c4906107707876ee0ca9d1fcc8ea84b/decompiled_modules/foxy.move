module 0xd3554495317b79f3b672e239855b5f3d1c4906107707876ee0ca9d1fcc8ea84b::foxy {
    struct FOXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXY>(arg0, 9, b"FOXY", b"Sui Foxy", b"Ali the Fox is a popular Chinese cartoon character created by Xu Han", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmPRUtfv9qAfsKv3kpp6E8SvhM3BT3tAw6mh8M587r6GY2?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOXY>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

