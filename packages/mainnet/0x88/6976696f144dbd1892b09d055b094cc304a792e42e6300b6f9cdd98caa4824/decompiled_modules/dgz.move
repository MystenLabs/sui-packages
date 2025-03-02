module 0x886976696f144dbd1892b09d055b094cc304a792e42e6300b6f9cdd98caa4824::dgz {
    struct DGZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGZ>(arg0, 9, b"DGZ", b"Dogzilla", b"Dog vs Godzilla", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/45340bbc10a4fd051bdbba2faf6c36efblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

