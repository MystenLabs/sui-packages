module 0x1cf319c942ab6a9cbac8677b8c39c46bce161f5372fb3aaa24d208283887af57::jo {
    struct JO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JO>(arg0, 6, b"JO", b"JO", b"sdsdsdsdsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreiez43lssgngn4aheerwio56a7v2mir224jzqypk7lptdbjqgfzsu4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JO>>(v2, @0x519fbd5bf1a0172e756473d88916e27aeb820abadf937b693ff1b80ff66f7760);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JO>>(v1);
    }

    // decompiled from Move bytecode v6
}

