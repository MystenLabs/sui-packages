module 0x147b3343f6724f585b340b826bb599807ae7d83f917a54aa84912193d166dd3::love {
    struct LOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVE>(arg0, 11, b"LOVE", b"LOVE", b"THE TICKER IS $LOVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/jpg;base64,/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAQDAwQDAwQEAwQFBAQFBgoHBgYGBg0JCggKDw0QEA8NDw4RExgUERIXEg4PFRwVFxkZGxsbEBQdHx0aHxgaGxr/2wBDAQQFBQYFBgwHBwwaEQ8RGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhoaGhr/wAARCAALAAsDASIAAhEBAxEB/8QAFwAAAwEAAAAAAAAAAAAAAAAABAUHCP/EACYQAAEDAwIFBQAAAAAAAAAAAAECAwQFERIAQQcTFCEiFVJhcYH/xAAVAQEBAAAAAAAAAAAAAAAAAAAEBv/EACARAQABBAAHAAAAAAAAAAAAAAECAAMRIQUSFCJBUfD/2gAMAwEAAhEDEQA/ANHVIyYzspqtuKiTEspFTIISJgt3WtVhm0ojx9oyb8U5p0dEoXEbpmvQ58WnU7EdPGlX5jSNkkYG3wm/YWG2qbVKXDnS6c9MjNPuxnytlS03KDiTcfqQfsA7aa6V1GjBVFLjOLYQtxXzzBI9aH4O01X/2Q==")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOVE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

