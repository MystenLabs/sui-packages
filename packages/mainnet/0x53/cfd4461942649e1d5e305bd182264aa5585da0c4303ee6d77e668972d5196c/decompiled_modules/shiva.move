module 0x53cfd4461942649e1d5e305bd182264aa5585da0c4303ee6d77e668972d5196c::shiva {
    struct SHIVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIVA>(arg0, 9, b"Shiva", b"ShivaShambhoo", b"Introducing Shiva Coin, the ultimate digital asset inspired by the Hindu deity Shiva. Harnessing cutting-edge blockchain technology, Shiva Coin ensures secure, fast, and scalable transactions. Empowering users with innovative smart contract capabilities, it represents a new era in cryptocurrency. Join the revolution with Shiva Coin today!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gHYSUNDX1BST0ZJTEUAAQEAAAHIAAAAAAQwAABtbnRyUkdCIFhZWiAH4AABAAEAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAACRyWFlaAAABFAAAABRnWFlaAAABKAAAABRiWFlaAAABPAAAABR3dHB0AAABUAAAABRyVFJDAAABZAAAAChnVFJDAAABZAAAAChiVFJDAAABZAAAAChjcHJ0AAABjAAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAAgAAAAcAHMAUgBHAEJYWVogAAAAAAAAb6IAADj1AAADkFhZWiAAAAAAAABimQAAt4UAABjaWFlaIAAAAAAAACSgAAAPhAAAts9YWVogAAAAAAAA9tYAAQAAAADTLXBhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABtbHVjAAAAAAAAAAEAAAAMZW5VUwAAACAAAAAcAEcAbwBvAGcAbABlACAASQBuAGMALgAgADIAMAAxADb/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCACLAPoDASIAAhEBAxEB/8QAHAAAAgMBAQEBAAAAAAAAAAAABQYDBAcCAQgA/8QAPhAAAgEDAgQEAwUHAgUFAAAAAQIDAAQRBSEGEjFBEyJRYQdxgRQjMkKRFVJiobHB0SQzFjRDU3NykuHw8f/EABoBA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHIVA>(&mut v2, 700000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIVA>>(v2, @0xce08834b80198fdc1a6e38ed4cf5aadcede652ba6f645d01c78ad75acba08122);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

