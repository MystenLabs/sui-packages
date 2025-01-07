module 0xd4d2ae054f6e8396c6ed30860666ad35b7b3d69c41befe50ac382c7e6acd597e::kok {
    struct KOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOK>(arg0, 6, b"KoK", b"Kind of Kindness", x"446f20796f75206c6f766520616e696d616c733f20416e696d616c73206c6f766520796f7520666f722073757265210a506172746963697061746520696e20616e696d616c207368656c746572206275696c64696e6720696e20546861696c616e64210a4a757374206265206b696e64202d206a75737420627579206d696e6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/animals1_8a81e6be11.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

