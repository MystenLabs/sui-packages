module 0x43efc4f66a1c7496a8b8a17b1bcc0d30cff69be3c67b0712a53c6266a453356f::mvm {
    struct MVM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MVM>(arg0, 6, b"MVM", b"MVM", b"Noo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreicklgen4cdyazp3ary7thhwbykx3hj37sezspztn62mzbhanrbvbe")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MVM>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVM>>(v2, @0xfe65cf3f401586ad76108d97b4a49fa382c3b16235f36e0fc972035b25414e9e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MVM>>(v1);
    }

    // decompiled from Move bytecode v6
}

