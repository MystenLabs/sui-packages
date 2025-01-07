module 0xee98a02e4408a634810419f6640e02067cc1f21ecc505ba05ff8869c499a104e::nexf {
    struct NEXF has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NEXF>, arg1: 0x2::coin::Coin<NEXF>) {
        0x2::coin::burn<NEXF>(arg0, arg1);
    }

    fun init(arg0: NEXF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEXF>(arg0, 9, b"NexF", b"NexF", b"NexF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZhWQWqEVt4jwQpNp9DMhN9e2XvnWNFPCLQSkd6p2gHQj")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEXF>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEXF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEXF>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

