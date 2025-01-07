module 0xd788403cbc9faa3614ca1cb6314c1d71864efb7ed6cdb6e83243ea3e6743bcfe::nfs {
    struct NFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFS>(arg0, 9, b"NFS", b"NOT FOR SALE", b"NFS are NOT FOR SALE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.ethoswallet.xyz/ipfs/bafybeiadpg432vtvkzuzo4u2cj44jg7xrgdwdtyk5rnu6xvhnaecjsk754")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NFS>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

