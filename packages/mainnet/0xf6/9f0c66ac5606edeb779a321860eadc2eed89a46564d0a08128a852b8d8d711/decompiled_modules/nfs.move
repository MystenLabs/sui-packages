module 0xf69f0c66ac5606edeb779a321860eadc2eed89a46564d0a08128a852b8d8d711::nfs {
    struct NFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFS>(arg0, 6, b"NFS", b"NOT FUCKING SELLING", b"Introducing $NFS (Not F***ing Selling)  The Wolves of Wall Street.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NFS_e20d9e6ab2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

