module 0x89deda2eed35ed02c2572d8d2a233b7ad2b8b28707c7115012c1a9fe324151ea::sfs {
    struct SFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFS>(arg0, 6, b"SFS", b"Smoking Fish Sui", b"Smoking Fish is a new Star Wars-themed memecoin on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_13_45_50_2453df2b9e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

