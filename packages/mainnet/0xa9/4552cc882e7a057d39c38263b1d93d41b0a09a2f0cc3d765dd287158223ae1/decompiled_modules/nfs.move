module 0xa94552cc882e7a057d39c38263b1d93d41b0a09a2f0cc3d765dd287158223ae1::nfs {
    struct NFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFS>(arg0, 6, b"NFS", b"NongFuSpring", b"nong fu spring a little sweet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_ae828a1b_2f52b5c807.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

