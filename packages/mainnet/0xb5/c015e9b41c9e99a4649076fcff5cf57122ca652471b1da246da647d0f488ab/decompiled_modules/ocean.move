module 0xb5c015e9b41c9e99a4649076fcff5cf57122ca652471b1da246da647d0f488ab::ocean {
    struct OCEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCEAN>(arg0, 9, b"ocean", b"OCEAN", b"OCEAN COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gHYSUNDX1BST0ZJTEUAAQEAAAHIAAAAAAQwAABtbnRyUkdCIFhZWiAH4AABAAEAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAACRyWFlaAAABFAAAABRnWFlaAAABKAAAABRiWFlaAAABPAAAABR3dHB0AAABUAAAABRyVFJDAAABZAAAAChnVFJDAAABZAAAAChiVFJDAAABZAAAAChjcHJ0AAABjAAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAAgAAAAcAHMAUgBHAEJYWVogAAAAAAAAb6IAADj1AAADkFhZWiAAAAAAAABimQAAt4UAABjaWFlaIAAAAAAAACSgAAAPhAAAts9YWVogAAAAAAAA9tYAAQAAAADTLXBhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABtbHVjAAAAAAAAAAEAAAAMZW5VUwAAACAAAAAcAEcAbwBvAGcAbABlACAASQBuAGMALgAgADIAMAAxADb/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCAAoADwDASIAAhEBAxEB/8QAGgAAAgMBAQAAAAAAAAAAAAAAAAMFBgcCBP/EADIQAAIBAwMCBQIDCQEAAAAAAAECAwAEEQUSIQYxE0FRYXEUkRUiUhYjMlOBkqHB0fH/xAAaAQACAwEBAAAAAAAAAAAAAAACAwEEBQAG/8QAIhEAAgIBAwQDAAAAAAAAAAAAAQIAEQMFEkETFCFSFTFC/9oADAMBAAIRAxEAPwCd1i4l6hvJNLaUJCEaVwRkZXsB798VZOitOs+nNCkuIo2t3lOXkc5DADjgdv8A2qvHe3sGNnhcAgfu8YzXo8C4a1WU3Ts7HlEJ+9azYm27b8TMTMAbA8yF6/0+wk1JdUglElxOSJRvJIx2K+nxXi0LqvVtHVIoCGt0bIR15x5jNWVNFgnRcxh3BxjcQefapB+mIWXElvJHIgA5bLKPTtTAyKuxvMUyuzblNSldX6tc6+qs8IijyGbDZz8iouZrm7tVglO5Ext9q0WLSWt5tqiN4242TRcj+hFdSaBHLIW2Qxk9lC4/3TEy40XaBAyY3ck3M2hsJAjIuQpOSBXr/Cz+mr+mixwHbNbFm9zimfhUH8hf7j/yndwB9RIxHkx8eo9KqsIe/XeQd+G8690esdJKMeMjfl2/mJ+/zWVs7eZQ/ApwSUlcADPtVJsN8mUV1dvQTY7fqvpq0jKafNCjE5ywyfvTbnrDp+e32zywSOvbcMVkEdrMMmRgB6k0wWzMDkqy+RpXbqOY4azlH4E0z9o9CFvIYZ4RI/B4zx6c1yvUOnEgtdxYH8O1QMf4rMDaqrkHbx6Zz9+1dC2i77GYeu4HNGMCxZ1l/UCaONV0lmJa7TJ5712NV0QKAblSQOTu71nX0UBIIC8eRGKd9Bb/AKE+9H065nfKN6iQvhsxJcD2Jp8aKpyFUfNFFWDPNkkWRGfUmMhgFAHkeRQ947jGAPiiio2iH1WqrgLpo1GAOT6YpsVxGxHiLt8srRRUlRBTITVxrTxIQecfIpgvVIyHCj0IxRRQ1H9Qg1P/2Q==")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OCEAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCEAN>>(v2, @0x1ab0d59e80559e6867650e883513cb97f7a0774ab399a8c6747c69e588f5cdec);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

