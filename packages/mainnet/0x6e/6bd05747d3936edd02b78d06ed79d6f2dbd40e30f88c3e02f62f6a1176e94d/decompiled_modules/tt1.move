module 0x6e6bd05747d3936edd02b78d06ed79d6f2dbd40e30f88c3e02f62f6a1176e94d::tt1 {
    struct TT1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT1>(arg0, 9, b"TT1", b"TestToken1", b"TestTokenDescription1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gHYSUNDX1BST0ZJTEUAAQEAAAHIAAAAAAQwAABtbnRyUkdCIFhZWiAH4AABAAEAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAACRyWFlaAAABFAAAABRnWFlaAAABKAAAABRiWFlaAAABPAAAABR3dHB0AAABUAAAABRyVFJDAAABZAAAAChnVFJDAAABZAAAAChiVFJDAAABZAAAAChjcHJ0AAABjAAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAAgAAAAcAHMAUgBHAEJYWVogAAAAAAAAb6IAADj1AAADkFhZWiAAAAAAAABimQAAt4UAABjaWFlaIAAAAAAAACSgAAAPhAAAts9YWVogAAAAAAAA9tYAAQAAAADTLXBhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABtbHVjAAAAAAAAAAEAAAAMZW5VUwAAACAAAAAcAEcAbwBvAGcAbABlACAASQBuAGMALgAgADIAMAAxADb/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCAAQAAwDASIAAhEBAxEB/8QAFwAAAwEAAAAAAAAAAAAAAAAAAQQGCP/EACgQAAEEAQMDAgcAAAAAAAAAAAECAwQRBQAGBxIhQQgTFBUiMTJRcf/EABQBAQAAAAAAAAAAAAAAAAAAAAD/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwC6zGWwvA+1trYzEbZXlvmSvh35MYBK3VUnqWpXSepSyr6UEgUCAQBpDk3gLa+f3OrIxJLGE95pJdjsU2hS7NrCaoWKuq7gn7k6Ppq5ZgZfYTmL3FNbj5DARipx15VByKgdnL/aRST57A+dZu5h5MyG+N8zMpDkyYuPQBHhtNuKRTSSSCoA/kSST/a8aD//2Q==")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TT1>(&mut v2, 1212000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT1>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TT1>>(v1);
    }

    // decompiled from Move bytecode v6
}

