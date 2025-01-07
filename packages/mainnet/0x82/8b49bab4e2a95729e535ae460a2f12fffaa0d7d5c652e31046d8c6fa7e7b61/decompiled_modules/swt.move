module 0x828b49bab4e2a95729e535ae460a2f12fffaa0d7d5c652e31046d8c6fa7e7b61::swt {
    struct SWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWT>(arg0, 9, b"SWT", b"Sui wallet token", b"Sui wallet token off.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://play-lh.googleusercontent.com/w2KKtDdJmmTDSSXUD-YM3sAPUe7yMJHLGEOfYMxSIviTVBfMm1n2G3FOG6ys6xiVPkVw=w240-h480-rw")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SWT>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWT>>(v1);
    }

    // decompiled from Move bytecode v6
}

