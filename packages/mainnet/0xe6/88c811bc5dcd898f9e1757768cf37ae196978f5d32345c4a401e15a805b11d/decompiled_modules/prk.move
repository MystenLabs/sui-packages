module 0xe688c811bc5dcd898f9e1757768cf37ae196978f5d32345c4a401e15a805b11d::prk {
    struct PRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRK>(arg0, 6, b"Prk", b"Prickle", b"ricks parasite friends have just let loose there going to the moon for the loot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmZcAvSNQfH4fzgv8rwtu3t2sjMTXSJh5wtyy9LwWtAUTV?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PRK>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRK>>(v2, @0xd3a665066ee7f19628771af3b4d81a7719a2a1502d20d3ff8cf3b176d20a3fb2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

