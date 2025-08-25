module 0xc3887c968a712d7e142ab71375fb8f4d79ef6ba695afc13f1c98608d325c3283::fdfsfsd {
    struct FDFSFSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDFSFSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDFSFSD>(arg0, 9, b"fdfsfsd", b"11111", b"fsdgsgfdgdfhdfgsdfsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FDFSFSD>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDFSFSD>>(v2, @0xf9d5debc75ce489c5babd5b8427ad1385e64d282ae450d1024167d3da41b637c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FDFSFSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

