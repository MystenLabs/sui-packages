module 0x1ef625ab5c3751b0a73de35c303a52dd9a8a82549074b2ca3997f8e244c964ed::nfs {
    struct NFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFS>(arg0, 6, b"NFS", b"Need for Speed ", x"5468652066617374657374204d656d6520696e20547572626f7320616e642053554920636861696e2e0a5769746820646f787865642070696c6f74732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959874233.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NFS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

