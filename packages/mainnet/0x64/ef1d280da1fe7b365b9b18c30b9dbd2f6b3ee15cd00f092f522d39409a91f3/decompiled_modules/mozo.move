module 0x64ef1d280da1fe7b365b9b18c30b9dbd2f6b3ee15cd00f092f522d39409a91f3::mozo {
    struct MOZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOZO>(arg0, 9, b"Mozo", b"Mozo", b"Mozo is an exclusive digital collectible on the blockchain, designed for collectors who appreciate true scarcity. With a mathematically limited supply and deflationary mechanics, Mozo is a representation of rare digital assets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gHYSUNDX1BST0ZJTEUAAQEAAAHIAAAAAAQwAABtbnRyUkdCIFhZWiAH4AABAAEAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAACRyWFlaAAABFAAAABRnWFlaAAABKAAAABRiWFlaAAABPAAAABR3dHB0AAABUAAAABRyVFJDAAABZAAAAChnVFJDAAABZAAAAChiVFJDAAABZAAAAChjcHJ0AAABjAAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAAgAAAAcAHMAUgBHAEJYWVogAAAAAAAAb6IAADj1AAADkFhZWiAAAAAAAABimQAAt4UAABjaWFlaIAAAAAAAACSgAAAPhAAAts9YWVogAAAAAAAA9tYAAQAAAADTLXBhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABtbHVjAAAAAAAAAAEAAAAMZW5VUwAAACAAAAAcAEcAbwBvAGcAbABlACAASQBuAGMALgAgADIAMAAxADb/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCAD1APoDASIAAhEBAxEB/8QAHAABAAEFAQEAAAAAAAAAAAAAAAgCBAUGBwMB/8QARxAAAgEDAgEFCgwEAwkAAAAAAAECAwQFBhEhBxITMWEUFkFRU3F0gZLSCCIyN0JSVmKRlKGxFSM0sjZywiQlJkSCs")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOZO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOZO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

