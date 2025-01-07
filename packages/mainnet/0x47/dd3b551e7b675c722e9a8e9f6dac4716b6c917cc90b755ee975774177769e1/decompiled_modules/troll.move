module 0x47dd3b551e7b675c722e9a8e9f6dac4716b6c917cc90b755ee975774177769e1::troll {
    struct TROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLL>(arg0, 9, b"TROLL", b"Troll Sui", b"$TROLL COIN is a memebreaking cryptocurrency that embraces the spirit of internet culture. With a strong community and a renounced contract, it aims to bring laughter and fun. Join us on this exciting journey to becoming one of the top meme coins available on thy internet. Telegram : https://t.me/suitroll . X : https://x.com/Troll_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gHYSUNDX1BST0ZJTEUAAQEAAAHIAAAAAAQwAABtbnRyUkdCIFhZWiAH4AABAAEAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAACRyWFlaAAABFAAAABRnWFlaAAABKAAAABRiWFlaAAABPAAAABR3dHB0AAABUAAAABRyVFJDAAABZAAAAChnVFJDAAABZAAAAChiVFJDAAABZAAAAChjcHJ0AAABjAAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAAgAAAAcAHMAUgBHAEJYWVogAAAAAAAAb6IAADj1AAADkFhZWiAAAAAAAABimQAAt4UAABjaWFlaIAAAAAAAACSgAAAPhAAAts9YWVogAAAAAAAA9tYAAQAAAADTLXBhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABtbHVjAAAAAAAAAAEAAAAMZW5VUwAAACAAAAAcAEcAbwBvAGcAbABlACAASQBuAGMALgAgADIAMAAxADb/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCAD6APoDASIAAhEBAxEB/8QAHAABAAICAwEAAAAAAAAAAAAAAAYHBQgCAwQB/8QAUhAAAQMDAQQGBQYICQsFAQAAAQIDBAAFEQYHEiExE0FRYXGBFCKRobEjMkJSYsEVFkNjcoKS0SQlMzRzorLS8AgXN")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TROLL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

