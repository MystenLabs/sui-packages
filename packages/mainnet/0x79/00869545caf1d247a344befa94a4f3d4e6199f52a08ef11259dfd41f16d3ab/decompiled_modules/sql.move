module 0x7900869545caf1d247a344befa94a4f3d4e6199f52a08ef11259dfd41f16d3ab::sql {
    struct SQL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQL>(arg0, 9, b"SQL", b"squirrel", x"53637572727920696e746f20736176696e6773207769746820537175697272656c436f696e3a20546865206e757474696573742063727970746f63757272656e637920746861742773207374617368696e6720617761792070726f6669747320616e642064656c69766572696e672061636f726e2d73697a656420696e766573746d656e747320746861742067726f772120f09f90bfefb88ff09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ad84fee-49b6-4fd4-8c4a-05a9f8661b89.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQL>>(v1);
    }

    // decompiled from Move bytecode v6
}

