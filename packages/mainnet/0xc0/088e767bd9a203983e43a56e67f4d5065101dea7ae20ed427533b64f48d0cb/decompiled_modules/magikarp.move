module 0xc0088e767bd9a203983e43a56e67f4d5065101dea7ae20ed427533b64f48d0cb::magikarp {
    struct MAGIKARP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGIKARP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGIKARP>(arg0, 9, b"magikarp", b"Magikarp", b"King Pokemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/6e214fae-adb1-4d5e-a245-57c0539c2072/de2gw03-c7032f75-32ad-4100-b99b-0e67ae09099a.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzZlMjE0ZmFlLWFkYjEtNGQ1ZS1hMjQ1LTU3YzA1MzljMjA3MlwvZGUyZ3cwMy1jNzAzMmY3NS0zMmFkLTQxMDAtYjk5Yi0wZTY3YWUwOTA5OWEucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.1BLxgeqRUvB0fbh3sTRylsSyL7Ue5PKuxpOX4QHMR4I")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAGIKARP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGIKARP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGIKARP>>(v1);
    }

    // decompiled from Move bytecode v6
}

