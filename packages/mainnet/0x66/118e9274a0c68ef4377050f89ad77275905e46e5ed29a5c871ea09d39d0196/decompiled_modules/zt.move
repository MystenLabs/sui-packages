module 0x66118e9274a0c68ef4377050f89ad77275905e46e5ed29a5c871ea09d39d0196::zt {
    struct ZT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZT>(arg0, 9, b"ZT", b"Zeta", b"Zeta is based on Finace", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/378539cae0f87de42c57351aed9a3e62blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

