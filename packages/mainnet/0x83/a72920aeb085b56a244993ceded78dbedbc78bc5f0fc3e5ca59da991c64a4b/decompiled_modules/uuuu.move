module 0x83a72920aeb085b56a244993ceded78dbedbc78bc5f0fc3e5ca59da991c64a4b::uuuu {
    struct UUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: UUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UUUU>(arg0, 9, b"uuuu", b"uuuu", b"uuuuu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/ISYhfhs0P2-mKLqh1bBgjOagHywz8Ia8Sz6kZ9NMHOM")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UUUU>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UUUU>>(v2, @0x64618fc023c7e6ec5fc6d7dd2046b7978402ad9c7bad279e840d56017abb1b7e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UUUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

