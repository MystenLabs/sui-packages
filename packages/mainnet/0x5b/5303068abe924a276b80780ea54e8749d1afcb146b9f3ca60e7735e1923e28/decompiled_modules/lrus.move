module 0x5b5303068abe924a276b80780ea54e8749d1afcb146b9f3ca60e7735e1923e28::lrus {
    struct LRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LRUS>(arg0, 9, b"LRUS", b"lazywalrus", b"lay back and let it pour in", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gHYSUNDX1BST0ZJTEUAAQEAAAHIAAAAAAQwAABtbnRyUkdCIFhZWiAH4AABAAEAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAACRyWFlaAAABFAAAABRnWFlaAAABKAAAABRiWFlaAAABPAAAABR3dHB0AAABUAAAABRyVFJDAAABZAAAAChnVFJDAAABZAAAAChiVFJDAAABZAAAAChjcHJ0AAABjAAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAAgAAAAcAHMAUgBHAEJYWVogAAAAAAAAb6IAADj1AAADkFhZWiAAAAAAAABimQAAt4UAABjaWFlaIAAAAAAAACSgAAAPhAAAts9YWVogAAAAAAAA9tYAAQAAAADTLXBhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABtbHVjAAAAAAAAAAEAAAAMZW5VUwAAACAAAAAcAEcAbwBvAGcAbABlACAASQBuAGMALgAgADIAMAAxADb/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCACIAPoDASIAAhEBAxEB/8QAHAAAAQQDAQAAAAAAAAAAAAAABAMFBgcAAQII/8QARhAAAgEDAgMEBgcFBwMDBQAAAQIDAAQRBSEGEjEHE0FRFCJhcYGRFSMyQpKhsVJUYpPRJDM0Q1PB4VVy8AgWgjVEg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LRUS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LRUS>>(v2, @0x7a0cbdfceaad556c7f79c9051f006e0e53ed0893c9237079ef90932a62a01453);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LRUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

